---
# You can also start simply with 'default'
theme: seriph
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
background: /assets/background.png
# some information about your slides (markdown enabled)
title: Metastable Failures
info: |
  Talk for Group Meeting
# apply unocss classes to the current slide
class: text-center
# https://sli.dev/features/drawing
drawings:
  persist: false
# slide transition: https://sli.dev/guide/animations.html#slide-transitions
transition: slide-left
# enable MDC Syntax: https://sli.dev/features/mdc
mdc: true
---

# Metastable Failures

A Beginner's Guide

<div class="color-red-400 font-size-2">
Disclaimer: Completely new area for me.
</div>


---
transition: fade-out
---

# What are Metastable Failures?

> Metastable failures occur in open systems with an uncontrolled source of load where a trigger causes the system to enter <b>a bad state that persists even when the trigger is removed</b>.
>
> In this state the goodput (i.e., throughput of useful work) is unusably low, and there is a sustaining effect—often involving work amplification or decreased overall efficiency that prevents the system from leaving the bad state.

<br />

## Sources

1. *"Metastable Failures in Distributed Systems"* - Bronson et al, HotOS '21
2. *"Metastable Failures in the Wild"* - Huang et al, OSDI '22

<!-- 
But first, a story
-->

---
transition: slide-up
level: 2
---

<v-click>

- Little Ronnie joins a secret team of devs to manage the infrastructure of a country-wide exam.
</v-click>

<v-click>

- Ronnie learns Kubernetes on the job.

</v-click>
<v-click>

- He deploys a critical CPU-intensive service, **but forgets to load test it before opening it to the public.**
</v-click>
<v-click>

- The service broke within a minute of opening, and wouldn't recover even when the load went down.
</v-click>
<v-click>

- Ronnie spent 24 hours hot-fixing everything amidst a twitter-storm.

<div class="size-100 float-right">

![](/img/are-ya-winning-son.jpg)
</div>
</v-click>


<br /><br /><br />

<div v-click>

# Little Ronnie is me!

And the guy before me, apparently

</div>

--- #4
transition: fade-out
---

# What happened?


```mermaid {theme: 'neutral', scale: 0.8}
graph LR

CL[Clients: 1500 rps] ---> L[Load Balancer]

L ---> A[500 rps]
L ---> B[500 rps]
L ---> C[500 rps]

```

--- #5
transition: fade-out
---

# What happened?


```mermaid {theme: 'neutral', scale: 0.8}
graph LR

CL[Clients: 1600 rps] ---> L[Load Balancer]

L ---> A[534 rps ❌]
L ---> B[533 rps]
L ---> C[533 rps]

```

--- #6
transition: fade-out
---

# What happened?


```mermaid {theme: 'neutral', scale: 0.8}
graph LR

CL[Clients: 1600 rps] ---> L[Load Balancer]

L ---> B[800 rps ❌]
L ---> C[800 rps ❌]

```

--- #7
transition: fade-out
---

# What happened?


```mermaid {theme: 'neutral', scale: 0.8}
graph LR

CL[Clients: 1600 rps] ---> |❌| L[Load Balancer]


```

--- #8
transition: fade-out
---

# What happened?

Pods would come up and go down in oscillating fashion.

Only solution: Take system offline. Reboot everything.

Take everything back online at once.


--- #9
transition: slide-left
---

