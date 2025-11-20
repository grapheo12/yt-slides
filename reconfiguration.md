---
author: Shubham Mishra
title: Reconfiguration
subtitle: for SMR and its siblings
date: November 20, 2025
---

# What is Reconfiguration?

A configuration is a set of node $C = \{p_1, p_2, ..., p_N\}$ executing a particular protocol.
 
Reconfiguration deals with going from a old set of nodes $C_{old}$ to a new one $C_{new}$.

# Why bother?

- In a long running cluster, crashes are inevitable.

- Can't stop the world to replace a node.

Anecdote: One reason why Microsoft CCF hasn't been able to use PBFT is because there is no standard way to change configuration.


# What makes it hard?

- New nodes need to catch up.

- Old nodes may die prematurely.

- Two majorities may commit different things.

- Who do clients talk to?

- What if you are lying about the new configuration?

- How much downtime can I tolerate?

- ...

# Formalizing Requirements

## First principles: Safety

What does safety mean with multiple configurations?


### Is it ok to lose data between configurations?

- Usually not 😅.

::: incremental

- But maybe the old data has lost use.

:::

::: incremental

- Reconfiguration protocol: Simply startup the new cluster and kill the old one.

:::


### Is it ok to change the total order?


- Maybe ok... Think reconfiguring CRDT systems.


::: incremental

- Or, if all commands were committed but not executed/delivered to the clients.

:::

::: incremental

- Reconfiguration protocol: Startup the new cluster, divert the client traffic and let one node from the old config replay the log in parallel to the new cluster.

:::

::: incremental

- However, if any command was delivered in the old configuration, we must preserve the prefix of the log ending at it.

:::

### Some definitions

- A replica $p$ is "correct in $c$" if $p$ is part of $c$ and is correct in $c$ (but may not be part of any other configuration).

- $p$ is "$c$-correct" if $p$ is correct in $c$, $c$ is the latest config or, $p$ is in the $c+1$ config.

- $p$ is $g$-correct if it is correct in all configs.

- $p$ is $g_c$-correct if it is correct in all configs $\geq c$.

### Enhanced Total Order

If a replica <span style="color: red;">correct in $c$</span> delivers request $m$ at some sequence number,
and another replica <span style="color: green;">correct in $c'$</span> delivers request $m'$ in the same sequence number,
then $m = m'$ and $c = c'$.


### Definitions matter

![*well maybe not for CFT, but definitely for BFT*](img/dyno-definitions.png)



# Patterns

There's usually these patterns of reconfiguration protocols in literature:

- Using an external master.
- Making reconfiguration part of the log.
- Permissionless staking systems.


## Vertical Paxos

- Paxos with a twist: every ballot can have a new configuration of acceptors.

- Separate master node(s) that give a leader a ballot $b$.

- Phase 1 replaced with finding if there's any value voted for by in all ballots $< b$ in all *previous configurations*.

- Later extended to Multi-Paxos in MatchMaker Paxos paper.



## Delos

![Facebook's Logging System](img/delos.png)

---

- Configuration includes which sequence numbers goes to which loglet.

- Stores current configuration in a separate MetaStore, running Paxos.

- Reconfiguration policy: Seals current config, which may lead to failing appends, write new config, resume.

- Can even use different consensus protocols altogether in the loglets.



## Raft

- Reconfiguration as part of the log.

- Single nodes can join and leave directly on appending a Reconfiguration command.

- Wait for the last Reconfiguration command to fire the new one.

- There's one more system to make arbitrary changes:

---

![Joint Consensus](img/joint-consensus.png)


## Dyno

In a BFT setting, a node can't directly execute a Reconfiguration command on receiving.

Why?

::: incremental

- The leader may be equivocating!!

:::

---

Clients in BFT need $f + 1$ responses.

::: incremental

- Which $f$?

:::

---

![*Remember this?*](img/dyno-definitions.png)

---

Assumptions:

- Going from $c$ to $c + 1$, at least $Q_c$ $c$-correct replicas remain in $c + 1$.
- G-correct assumption: $max(f_c) + 1$ replicas never leave the system.

### Dyno-S

- Tie config changes to view changes.

- Every time a config change is committed, trigger a view change.

- Get support from $Q_c$ from old config and $Q_{c+1}$ from new config.

- Successful view change $\implies$ no progress possible in the lower views.

- Simple; but has downtime.


### Dyno

- As soon as a new node sends a Join command, it is added in a temporary membership to start catch-up process.

- Old config first commits and delivers a batch of membership requests.

- On adding a new node, increase the config number and then send history of config changes to the new node(s).

- New nodes start operating on receiving $2f_c + 1$ such history messages.


## Casper

- Casper is like linear PBFT but applied to blockchain: Justify == First phase, Finalize == Second phase.

- Safety is economical, if you finalize two conflicting blocks, $1/3rd$ of the validators get slashed.

---

- Config change is done by committing a new set of validators to blocks.

- Old config: Validator set of the last finalized block.

- New config: Validator set committed in the last finalized block.

- Finalizing condition: Use union of $2/3rd$ of old config and $2/3rd$ of new config.

---

![](img/casper-reconfig.webp)


# Are we done?

- As you can see, BFT reconfiguration is not "simple".

- Can we apply the Vertical/MatchMaker Paxos idea to simplify things?

- Can rotating leader protocols help, with cheaper view changes?

- Can we generalize the concept of reconfiguration? Think a partial order of configurations.
