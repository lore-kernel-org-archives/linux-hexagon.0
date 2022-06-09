From: Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
Date: Thu, 9 Jun 2022 20:30:58 +0900
Message-ID: <CA+_sPaoJGrXhNPCs2dKf2J7u07y1xYrRFZBUtkKwzK9GqcHSuQ@mail.gmail.com>
References: <20220608142723.103523089@infradead.org> <20220608144517.444659212@infradead.org>
 <YqG6URbihTNCk9YR@alley> <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XewJc/p+7yp1re11t6BfmEtfp27WPbXPnywgusXXTc=;
        b=dD0Bz9eW32MHk+TeRLS+QqFpXQSyJG1PFuM0sFc2oIQiPmRbBKI4wiAjUnrY0TOPB3
         vmLpoVIxPESYT9ISrrirk39KtLhSpCgEKtG3yrDCpv/Gh6ZWSamp4kS8RJg23gIGNIEa
         lDd2yagv7BcuRvFzrWxMhthjwknH7br96szys=
In-Reply-To: <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.

My emails are getting rejected... Let me try web-interface

Kudos to Petr for the questions and thanks to PeterZ for the answers.

On Thu, Jun 9, 2022 at 7:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> This is the tracepoint used to spool all of printk into ftrace, I
> suspect there's users, but I haven't used it myself.

I'm somewhat curious whether we can actually remove that trace event.
