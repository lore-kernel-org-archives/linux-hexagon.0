From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *"
 argument
Date: Wed, 21 Nov 2018 18:40:06 +0000
Message-ID: <20181121184004.jro532jopnbmru2m@pburton-laptop>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MmCyU0Yje/nlGHFABtgt9L8M5kGTdXATvxBNs+A/4QM=; b=EQGKsGrxbYfw4f
	zWZimJZqV70Pn1jGbr3nVsb+scR5CM61mcSMpfZhRd1Sn31201btctmaow53IWhjaduDnE3+XQMFJ
	7rYwV1V0AvAANvOFPlmTYM3jkyRMSMNglgRqJLl4hUrNJxhxTNsf6mgM9GRLEKL2vAQjMVEAej/22
	foQJM2FBlGGqkNZvSC9ktM/VlADBNMorBIoh4gP/PMCXvl0Nx81H0BFMiAjfhGolGnfk2goxjBk6D
	z3LsdIejLHvTEP6s4AdTvxYisvVkMr1tu3wWUkdJgAUXj9rFry/h2wFGlVS99DlB+gsjYeelTIx3P
	ICCe3rnHUh4IkwzP0Tnw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj6NIwOwDYiM8EmGFNjdseiFCv3nZaiMd/nWclCQeQU=;
 b=p9UO919Zy24E888qHWVGpN64uG89VePsQae2CZE7CVE269a5fMLRGmnfDe0xIRXOTrOm/byfhQCziyucnSI7u8q1nH0K+w6ZG2RQh9TXu3q22/3HNgHyKTtEY6A9JC0Iw8mSltTkJOP2F697E5K05Nkl16xyDuDrfoW1UMb492o=
In-Reply-To: <20181121004422.GA29053@altlinux.org>
Content-Language: en-US
Content-ID: <F706FB6922E03E429949DE755647EBBE@namprd22.prod.outlook.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Eugene Syromyatnikov <esyr@redhat.com>, Elvira Khabirova <lineprinter@altlinux.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "uclinux-h8-devel@lists.sourceforge.jp" <uclinux-h8-devel@lists.sourceforge.jp>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, linux-um@lists.infradea

Hi Dmitry,

On Wed, Nov 21, 2018 at 03:44:22AM +0300, Dmitry V. Levin wrote:
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
> 
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
> 
>%
> 
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index 0170602a1e4e..52b633f20abd 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -73,7 +73,7 @@ static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
>  #ifdef CONFIG_64BIT
>  	case 4: case 5: case 6: case 7:
>  #ifdef CONFIG_MIPS32_O32
> -		if (test_thread_flag(TIF_32BIT_REGS))
> +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS))
>  			return get_user(*arg, (int *)usp + n);
>  		else
>  #endif

This ought to be test_tsk_thread_flag(task, TIF_32BIT_REGS) instead of
open-coding test_tsk_thread_flag.

More fundamentally though, this change doesn't seem to be (directly)
related to the change you describe in the commit message - it's not
syscall_get_arch being modified here. I suspect this should be a
separate commit, or if not please explain in the commit message why this
change is included.

Compounding the lack of clarity is the fact that I only received this
patch, not the whole series, so I can't view the change in the context
of the rest of the series.

> @@ -140,14 +140,14 @@ extern const unsigned long sys_call_table[];
>  extern const unsigned long sys32_call_table[];
>  extern const unsigned long sysn32_call_table[];
>  
> -static inline int syscall_get_arch(void)
> +static inline int syscall_get_arch(struct task_struct *task)
>  {
>  	int arch = AUDIT_ARCH_MIPS;
>  #ifdef CONFIG_64BIT
> -	if (!test_thread_flag(TIF_32BIT_REGS)) {
> +	if (!test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS)) {
>  		arch |= __AUDIT_ARCH_64BIT;
>  		/* N32 sets only TIF_32BIT_ADDR */
> -		if (test_thread_flag(TIF_32BIT_ADDR))
> +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_ADDR))
>  			arch |= __AUDIT_ARCH_CONVENTION_MIPS64_N32;
>  	}
>  #endif

This does seem like the described change, but there are 2 more instances
of open-coding test_tsk_thread_flag which ought to be cleaned up.

Thanks,
    Paul
