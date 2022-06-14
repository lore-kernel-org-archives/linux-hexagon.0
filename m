From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
Date: Tue, 14 Jun 2022 10:37:32 -0400
Message-ID: <20220614103732.489ba62b@gandalf.local.home>
References: <20220608142723.103523089@infradead.org>
        <20220608144517.444659212@infradead.org>
        <YqG6URbihTNCk9YR@alley>
        <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
        <CA+_sPaoJGrXhNPCs2dKf2J7u07y1xYrRFZBUtkKwzK9GqcHSuQ@mail.gmail.com>
        <YqHvXFdIJfvUDI6e@alley>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <YqHvXFdIJfvUDI6e@alley>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org>
Cc: Sergey Senozhatsky <senozhatsky-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org, mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vgupta-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, ulli.kroll-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcain-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, chenhuacai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-f95k8chpbVdBDLzU/O5InQ@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org, stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org, shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org

On Thu, 9 Jun 2022 15:02:20 +0200
Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org> wrote:

> > I'm somewhat curious whether we can actually remove that trace event.  
> 
> Good question.
> 
> Well, I think that it might be useful. It allows to see trace and
> printk messages together.

Yes people still use it. I was just asked about it at Kernel Recipes. That
is, someone wanted printk mixed in with the tracing, and I told them about
this event (which they didn't know about but was happy to hear that it
existed).

-- Steve
