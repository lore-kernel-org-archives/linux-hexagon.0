From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 19/36] Hexagon: Add ptrace support
Date: Wed, 17 Aug 2011 21:47:02 +0200
Message-ID: <2462338.kr2t1K64O5@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163521.637768691@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110817163521.637768691@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wednesday 17 August 2011 11:35:16 Richard Kuo wrote:
> +       switch (request) {
> +       case PTRACE_PEEKUSR:    /* read register specified by addr. */
> +               ret = ptrace_peekusr(child, addr, (void __user *) data);
> +               break;
> +       case PTRACE_POKETEXT:   /* write the word at location addr. */
> +       case PTRACE_POKEDATA:
> +               ret = generic_ptrace_pokedata(child, addr, data);
> +               break;
> +       case PTRACE_POKEUSR:    /* write register specified by addr. */
> +               ret = ptrace_pokeusr(child, addr, data);
> +               break;
> +       case PTRACE_GETREGS:
> +               ret = ptrace_getregs(child, (void __user *) data);
> +               break;
> +       case PTRACE_SETREGS:
> +               ret = ptrace_setregs(child, (void __user *) data);
> +               break;
> +       default:

I believe the current way to do this is to use regsets for everything,
see arch/openrisc/kernel/ptrace.c

	Arnd
