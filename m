From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] mm: Move mem_init_print_info() into mm_init()
Date: Wed, 17 Mar 2021 11:48:50 -0700
Message-ID: <2a7d6e39-b293-7422-87b0-741f1ab0c22c@intel.com>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
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
	 bh=aBbZyPN7Xw8MP7U9jeC2TQZnIfhAY4KTO/8VfRKxH5o=; b=VHhKQ0d7pCXG81AQK1pdb0Elw
	/sHFA9Vwq40xM3vERMI6/HuYmeQhAvzpE+Cc6XO6ihhNoadHYNYac7TsdOGWSYYi2lRliZCKCrUEr
	lcy5cwc0acDn0d+LDUUu5Wj83dwTuDNxb7VJGT+vLTKZEhvpQ2HOLb9vsKKcXwCItJFIaLGh5FE7G
	NuB3vyCu8ajcAOFIUey7mtflHMZGBK1S8UUTUP/MBJ1YbUuWco8zyAD9nDi5kSbLQ/Tgl3UNX66uc
	K+kl/tNlVmHhCFOjcN9VzEtQuIJX0w6Qx7J8wGiJl6v7+DBLD7AcHSrvs8UTlWaR9IevaXz0F4gLa
	QyAGf19Mg==;
In-Reply-To: <20210317015210.33641-1-wangkefeng.wang@huawei.com>
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

On 3/16/21 6:52 PM, Kefeng Wang wrote:
> mem_init_print_info() is called in mem_init() on each architecture,
> and pass NULL argument, so using void argument and move it into mm_init().
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

It's not a big deal but you might want to say something like:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # x86 bits

Just to make it clear that I didn't look at the alpha bits at all. :)
