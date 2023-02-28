From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Date: Tue, 28 Feb 2023 07:22:36 -0800
Message-ID: <20230228152236.GA4088022@roeck-us.net>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <Y9l0w4M91DwYLO3N@ZenIV>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrCu0geLOi4OVGkwEDjMoWqOD6knh9EFuIYJINwxG2Q=;
        b=IGBBoowU11kDoWvFa5UzxduFuKkleISEIsB8g0SLdw3lG87SsG8+PsmkrCrm3TH2pt
         LBN/n5AsWe0dZ2AIgADeF8KWpj+ycPcePDpjwLCg0T63e6K3XjzdEZXIUgV6TE7WUBN1
         AK2CARlsdEe/OX1TbsU78oHzkcJn1RVW+c7oYGgocxiBXOe8c+dQkbo6AMBYWCYSeWRC
         vhMfw47fslKk3wVgBClGFXE6FBNXcORvFJZL+8l11ZidzustABk5nGG0x2gpRfO9RxJD
         PuL/N5Cl9Ya1t3fGA7nJ+DSi9olydAlsnnYP9GKF7V1L+IZjLHdL2hpD/GalkWFZw9V7
         1jRg==
Sender: Guenter Roeck <groeck7@gmail.com>
Content-Disposition: inline
In-Reply-To: <Y9l0w4M91DwYLO3N@ZenIV>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Jan 31, 2023 at 08:06:27PM +0000, Al Viro wrote:
> parisc equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
> to page tables.  In such case we must *not* return to the faulting insn -
> that would repeat the entire thing without making any progress; what we need
> instead is to treat that as failed (user) memory access.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/parisc/mm/fault.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> index 869204e97ec9..bb30ff6a3e19 100644
> --- a/arch/parisc/mm/fault.c
> +++ b/arch/parisc/mm/fault.c
> @@ -308,8 +308,11 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
>  
>  	fault = handle_mm_fault(vma, address, flags, regs);
>  
> -	if (fault_signal_pending(fault, regs))
> +	if (fault_signal_pending(fault, regs)) {
> +		if (!user_mode(regs))
> +			goto no_context;

0-day rightfully complains that this leaves 'msg' uninitialized.

arch/parisc/mm/fault.c:427 do_page_fault() error: uninitialized symbol 'msg'

Guenter

>  		return;
> +	}
>  
>  	/* The fault is fully completed (including releasing mmap lock) */
>  	if (fault & VM_FAULT_COMPLETED)
