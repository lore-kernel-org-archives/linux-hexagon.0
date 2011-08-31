From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 19/35] Hexagon: Add ptrace support
Date: Wed, 31 Aug 2011 16:07:41 +0200
Message-ID: <201108311607.41445.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190801.540467107@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190801.540467107@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> +
> +       switch (request) {
> +       case PTRACE_POKETEXT:   /* write the word at location addr. */
> +       case PTRACE_POKEDATA:
> +               return generic_ptrace_pokedata(child, addr, data);
> +       case PTRACE_POKEUSR:    /* write register specified by addr. */
> +               return ptrace_pokeusr(child, addr, data);
> +       case PTRACE_GETREGS:
> +               return copy_regset_to_user(child, &hexagon_user_view,
> +                                          REGSET_GPR, 0,
> +                                          sizeof(struct user_regs_struct),
> +                                          udata);
> +       case PTRACE_SETREGS:
> +               return copy_regset_from_user(child, &hexagon_user_view,
> +                                            REGSET_GPR, 0,
> +                                            sizeof(struct user_regs_struct),
> +                                            udata);

I don't remember if I commented on this or if it was for the c6x architecture
submission. Anyway, I think you should let all of this be handled through
the generic ptrace support like openrisc does.

	Arnd
