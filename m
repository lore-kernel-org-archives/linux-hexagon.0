From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Date: Wed, 19 Dec 2018 16:57:18 +0000
Message-ID: <20181219165718.tf5ly7yg5es7bvum@holly.lan>
References: <030d63848e4b0ef4d76ca24597ab8302a393d692.1544083483.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+bPgt6SnPDP0a4iYjPYGvwAQx/u+oM+zOzt+Sj62ZI=;
        b=TdUJ7NxQU18/CR8M37OgvTsSJnNBt8JiTVfWx+XFGuv2kFDhUzRIOLKtLp4+yD6Xwc
         2oydFOVxuY8MA1x43P7gMgXV6dwt/SxlX1uV1mzJkUoeplJFbAFqywD2cAOKH88ZjAho
         1vQW45WF0HsRCqVNO1Pc7MeteQj97v+P4f78I=
Content-Disposition: inline
In-Reply-To: <030d63848e4b0ef4d76ca24597ab8302a393d692.1544083483.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Jason Wessel <jason.wessel@windriv>

On Thu, Dec 06, 2018 at 08:07:38PM +0000, Christophe Leroy wrote:
> MIPS is the only architecture modifying arch_kgdb_ops during init.
> This patch makes the init static, so that it can be changed to
> const in following patch, as recommended by checkpatch.pl
> 
> Suggested-by: Paul Burton <paul.burton@mips.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied! Thanks.


> -
> ---
>  v2: Added acks from Daniel and Paul.
> 
>  arch/mips/kernel/kgdb.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index eb6c0d582626..31eff1bec577 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -394,18 +394,16 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  	return -1;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops;
> +struct kgdb_arch arch_kgdb_ops = {
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
> +#else
> +	.gdb_bpt_instr = { break_op, 0x00, 0x00, spec_op << 2 },
> +#endif
> +};
>  
>  int kgdb_arch_init(void)
>  {
> -	union mips_instruction insn = {
> -		.r_format = {
> -			.opcode = spec_op,
> -			.func	= break_op,
> -		}
> -	};
> -	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
> -
>  	register_die_notifier(&kgdb_notifier);
>  
>  	return 0;
> -- 
> 2.13.3
> 
