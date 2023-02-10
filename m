From: Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH 02/10] hexagon: fix livelock in uaccess
Date: Fri, 10 Feb 2023 02:59:41 +0000
Message-ID: <SN6PR02MB4205D40B41246B41EA8FD069B8DE9@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0LyAA3zAGeT51@ZenIV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UuS/bSHo2kkMDHPLWFzuJIyZBYgDcgGL07RnfaaOag0=; b=L1PC/rXneg7VT+
	uGwGTDFQbauMm6JROTiLJ+pZ0ZfV+2lkjDJdGd38nLG1B1yf5ssK4XdJx5ZZd1e53aKxD0cTqlU8l
	lixzPq6+JqXhbbDmUlYMISUQXP2mHjdW05OOl7DBKjAKuL2VouSnfe04avjQA4aPwDMJqyRoNhfcS
	wmrchfRxSzDQdZ4OaR66AhQa+jq81s+fiSd5XZfQapTzAAg3CFnRX14sRQP4my5mOtUGPvyYpY1fX
	lSL01kmOSz6m+GgFOYCEWkfozni7clmdprrOww+lpg4/gPXCAwVbhvPXLCF6i3wzvuDd+TXz3Wl6x
	KJwJAgH/FVkBwHqrRBzg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=PMdaGYZpGF22orovjSVuT60NlPXcv4+kqFOvDDIYePQ=;
 b=Z3veALbf+68QAY33DqNSH1vBntSADetQYkI4LOy5hyViSWII3V+FRmaviz2WcgvdluI2
 I/B6E27Ci0t6LlvQC3K+fwfnn/rkFXkdtLQHad8xfgSUXx5Wi4b5ubG2Lm15RvRaJGTA
 o5kEg26md9V+QDg7M0HhyBLtDh09Ia1QB/R/hmlzSaxdvLjTM/Rcf9Uy947dgYgNyNtX
 cdxyUMN90NTBaTsUlsP/fYX0X4SVIjPaO8noazzJ282TZ046tt9XMZJ7Kb7L64wSWpFO
 n24kyVPZ3g1n6gcTPteEoIkQZeGykz/oyZyt4oprbIfkhqaJ9nV8pEUOQKn+Yfsb68xS dQ== 
In-Reply-To: <Y9l0LyAA3zAGeT51@ZenIV>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Al Viro <viro@zeniv.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Tuesday, January 31, 2023 2:04 PM
> To: linux-arch@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org; linux-ia64@vger.kernel.org; linux-
> hexagon@vger.kernel.org; linux-m68k@lists.linux-m68k.org; Michal Simek
> <monstr@monstr.eu>; Dinh Nguyen <dinguyen@kernel.org>;
> openrisc@lists.librecores.org; linux-parisc@vger.kernel.org; linux-
> riscv@lists.infradead.org; sparclinux@vger.kernel.org; Linus Torvalds
> <torvalds@linux-foundation.org>
> Subject: [PATCH 02/10] hexagon: fix livelock in uaccess
> 
> WARNING: This email originated from outside of Qualcomm. Please be wary of
> any links or attachments, and do not enable macros.
> 
> hexagon equivalent of 26178ec11ef3 "x86: mm: consolidate
> VM_FAULT_RETRY handling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing
> anything
> to page tables.  In such case we must *not* return to the faulting insn -
> that would repeat the entire thing without making any progress; what we
> need
> instead is to treat that as failed (user) memory access.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/hexagon/mm/vm_fault.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
> index f73c7cbfe326..4b578d02fd01 100644
> --- a/arch/hexagon/mm/vm_fault.c
> +++ b/arch/hexagon/mm/vm_fault.c
> @@ -93,8 +93,11 @@ void do_page_fault(unsigned long address, long cause,
> struct pt_regs *regs)
> 
>         fault = handle_mm_fault(vma, address, flags, regs);
> 
> -       if (fault_signal_pending(fault, regs))
> +       if (fault_signal_pending(fault, regs)) {
> +               if (!user_mode(regs))
> +                       goto no_context;
>                 return;
> +       }
> 
>         /* The fault is fully completed (including releasing mmap lock) */
>         if (fault & VM_FAULT_COMPLETED)
> --
> 2.30.2

Acked-by: Brian Cain <bcain@quicinc.com>
