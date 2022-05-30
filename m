From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Mon, 30 May 2022 14:31:52 +0100
Message-ID: <YpTHSNQxzQxwJ4vQ@arm.com>
References: <20220527193936.30678-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XXTwOxv/n0NolP43p4OwZEf1QXtjTagOhM3vsXTV4bo=; b=BbeXEbGlpRvtLT
	EacQbgaf7JauyFQLkMLHCwPdnMO1pBOE74v/Jd5A8vRxvn8OB0qXo+9srnrurNZn+mibanIVPkW1D
	tXZ4m+S9EIoqvKj+L3PLvnW/XOFdgmtSqHBwWsPiwgV+ff2ouFLYIdDBUYti8Ct6+PJw/8idEOeEr
	HH9PsXIrLZyIAUrJik6jbk3obpGW4ixgxfWUNnREaYtouNRRwbhiMtYnvlO79OHZtXJaNXAWxDOIw
	wxmZ9IcspdbO1WJ5DVgesMESAxoj1HQyRFkXKITlgZGI8lFVQh4cOVc42f1lJUjpj71Zmx/w6pKiL
	DcKOq1zsh5KycmnXnOdw==;
Content-Disposition: inline
In-Reply-To: <20220527193936.30678-1-peterx@redhat.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@quicinc.com>, Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org, Alistair Popple <apopple@nvidia.com>, Jonas Bonn <jonas@southpole.se>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, Russell King <linux@armlinux.org.uk>, David Hildenbrand <david@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, May 27, 2022 at 03:39:36PM -0400, Peter Xu wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 77341b160aca..e401d416bbd6 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -607,6 +607,10 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
>  		return 0;
>  	}
>  
> +	/* The fault is fully completed (including releasing mmap lock) */
> +	if (fault & VM_FAULT_COMPLETED)
> +		return 0;
> +
>  	if (fault & VM_FAULT_RETRY) {
>  		mm_flags |= FAULT_FLAG_TRIED;
>  		goto retry;

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
