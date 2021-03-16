From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] mm: Move mem_init_print_info() into mm_init()
Date: Tue, 16 Mar 2021 14:16:35 -0700
Message-ID: <009553ee-8d7b-0b60-8457-f8ac66e27fb4@intel.com>
References: <20210316142637.92193-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3RwmF1xmgLkkz7knebGm2uaO5vyODm/Z6xGr7kBjjGc=; b=dCV2er26dOvVR0le4f4tMjAWK
	7bFSfG+QauaJC3M0MuQdM8kv0ZOk0ZmY0Bv7oInRTic9rpYSrpNa+mowd25e7p/e7dJBuKyDTOkM5
	iX9g7fhQRo9q7CroKJUpIO0Urb7ITCJm+HcUuxSpLu7z1RC6DiECOAq7QznS9uXALst9h9vt7KdDe
	onlFoM0b7/Cw3d7eLWcCXDXlUcKTCcpdbTd4VgW/+1fPM7y3EWagK5U1mobUUzS+7e240QcbEridm
	Q94PGXMmwu67Hf+FNY8p9qTEclA6ZIImXXWeOCUytV4bBv8kM/faOAoKPDW/gJvt+CKtgQeVjf8Sw
	LkRcNuutw==;
In-Reply-To: <20210316142637.92193-1-wangkefeng.wang@huawei.com>
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
To: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Richard Henderson <rth@twiddle.net>, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Huacai Chen <chenhuacai@kernel.org>, Jonas Bonn <jonas@southpole.se>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger

On 3/16/21 7:26 AM, Kefeng Wang wrote:
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 5430c81eefc9..aa8387aab9c1 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1350,8 +1350,6 @@ void __init mem_init(void)
>  		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
>  
>  	preallocate_vmalloc_pages();
> -
> -	mem_init_print_info(NULL);
>  }

Ignoring any issues with the printk...

Looks harmless enough on x86.  The 32-bit code has some cruft in
mem_init() after mem_init_print_info(), so this patch will change the
location of the mem_init_print_info(), but I think it's actually for the
better, since it will be pushed later in boot.  As long as the x86
pieces stay the same:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
