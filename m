From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: Re: [patch 05/36] Hexagon: Add syscalls
Date: Wed, 17 Aug 2011 22:12:20 +0200
Message-ID: <CACM3HyE=vHtr7Y-9k7PWvxmGt+O1bJyxs18CEmtzMdq9zOtfqw@mail.gmail.com>
References: <20110817163457.878854582@codeaurora.org>
	<20110817163520.334269161@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ga2vgo/nX7ztC0hzGVQyE4Ngm/PgnZYd9/ao+oa0GEk=;
        b=KSGe6RG+voSWHHecLQaZUWWDUJa4zPPuggSE8c2bm2bLCz4icYkHTDfF1jw80TCXeR
         FG0G/8wMuqp/DJYK3QtMa1GR21RXpaG6I0bwfbgAbUG7X7oEulzL1ZDXxziDFV2wM0bU
         dboLTXG8/9BugojSyAd3hXPNqocYvoFNRya+A=
In-Reply-To: <20110817163520.334269161@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

> +
> +#define __ARCH_WANT_SYSCALL_DEPRECATED
> +
> +#ifndef __GLIBC__
> +/* It seems these are all needed for uClibc...
> + * However, if glibc is compiled w/ these turned on, then it will
> + * will fail (typically with 32/64-bit compat problems). */
> +#define __ARCH_WANT_SYSCALL_OFF_T
> +#define __ARCH_WANT_SYSCALL_NO_AT
> +#define __ARCH_WANT_SYSCALL_NO_FLAGS
> +#endif
> +

These are no longer appropriate for the mainline kernel.  These
definitions are mainly intended to be used during a transitional
period until the necessary changes can be made in the required C
library.

The recommendation is to just carry these defines as an external patch
while the necessary changes are made in uClibc.  I've just about got
the necessary changes done and will send them to the uClibc mailing
list shortly, so hopefully the need for these defines will go away
really soon now.


> +asmlinkage int sys_fork(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct pt_regs *pregs =3D current_thread_info(=
)->regs;
> +
> + =C2=A0 =C2=A0 =C2=A0 return do_fork(SIGCHLD, pregs->SP, pregs, 0, N=
ULL, NULL);
> +}
> +
> +asmlinkage int sys_vfork(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct pt_regs *pregs =3D current_thread_info(=
)->regs;
> +
> + =C2=A0 =C2=A0 =C2=A0 return do_fork(CLONE_VFORK | CLONE_VM | SIGCHL=
D,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pregs->SP, pregs, 0, NULL, NULL);
> +}

These two are deprecated.

/Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-hexagon=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
