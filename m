From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v6 13/41] mm: Make pte_mkwrite() take a VMA
Date: Mon, 20 Feb 2023 21:24:07 +0000
Message-ID: <d46aa53a3e7265facaaa3533b75ccd8d903cd32a.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
	 <20230218211433.26859-14-rick.p.edgecombe@intel.com>
	 <875ybxywu9.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u57bfDi67+L4wdJrQEC1NdTrzNih8mtOUojzL3xaI0E=; b=HQxKw1EFy4OPeg
	3G2DiDC/EVjGghilcEChro/LAiiRxKG1mr0qlD8tEiMe+3IxFGQL9L/+lfKvHY+qc3z3D13W1+YTh
	VlFQnYSjvkD4s09wkXbiQf5Opp1UjFb52g3MKvI4z7DIwu9U7OknqAilAVLVUAHVhUeF+MpakVnfN
	WfKZ/g9IJPiUtDBlzNktzrqrifADFT/weXpEQ5KIyi6C7uH5HKaXhUYdb6AxeJcxVupWUboYfD9Q1
	1p56x/46m6kFY53nkyRRYV7fVfGewLccVqh7tR2Q8QlUrTWoiZE+19KkVex8LqngkKFIcroUg8BjW
	yg4u4fFZrXMC+XAQ9T0g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676928254; x=1708464254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K3K05a6gyOL/k11aIXAtq7ahCnYzje8Vl9Dl05sRF1o=;
  b=SP8jCtzX6qZ4UPEDuAZQiVhWLe4FxyArcv5XiM+bJvBkm6JQYI7gpbkR
   1jtEPhdDwOedvSICdg5wJdQVyGtsEV0jkKAz379842pR7b/ZagbVJuqgj
   GhIq2yEQy2TdvJtBVQ2IMPJd9oRSr4iWDr4Iuf5NKAHbpwEZe+In+/I7o
   GCd2lg7x0TK5UlhKBCwu42dWCDLWv0dWtLa4nwpmNhTxk4I5Syg/DIV/n
   KRWfgkQdC2NdITOsNJZtMJNqhOJhDmvp5xmFkFeAUpenxdGRzXfOd8R4p
   Ir8tKWn/sDShT+0ZDCud2xCXt+mi8hv/oacLxKWVnWAJ1eayA2sQxZSOR
   w==;
In-Reply-To: <875ybxywu9.fsf@mpe.ellerman.id.au>
Content-Language: en-US
Content-ID: <C87D725E738A25438365E1A8F10AD517@namprd11.prod.outlook.com>
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
To: "david@redhat.com" <david@redhat.com>, "bsingharora@gmail.com" <bsingharora@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>, "Syromiatnikov,
 Eugene" <esyr@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "keescook@chromium.org" <keescook@chromium.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Eranian, Stephane" <eranian@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "fweimer@redhat.com" <fweimer@redhat.com>, "nadav.amit@gmail.com" <nadav.amit@gmail.com>, "jannh@google.com" <jannh@google.com>, "dethoma@microsoft.com" <dethoma@microsoft.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>, hjl.tools@gmail.co
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "dinguyen@kernel.org" <dinguyen@kernel.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, monstr

On Mon, 2023-02-20 at 12:00 +1100, Michael Ellerman wrote:
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks!
