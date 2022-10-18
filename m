From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] mm: remove kern_addr_valid() completely
Date: Tue, 18 Oct 2022 10:03:50 +0200
Message-ID: <Y05d5ii/2OqYLqa0@osiris>
References: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
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
	List-Owner; bh=Y2EAfbBkHWdieviAEUXjycFKQVUkYuz28cxK3a7HW+M=; b=vq+hHJ9LkcdWhX
	rHuAQ/p8QCGV6fEFbzRp7twjSmXGUnntj7Zx883HB8fqrTq1reXNaZQwhi0SYCsNKccKX6GjBwYVq
	Wq70UwhqShJ7LVJ7dUgi565GOy06SyAAIwcE5yosGhKN/t9gEQPlp9cdkpZ+Qx3YoQeEksDFHzkBY
	i14UAnFf+bVkRzRjhO8CDSR+pRxIPhDbBJQ5K+R6qc2suCI66IhneG/K6JNKSwC0oecgL41j+mPDy
	+ITxMCPvU0XQeshVMUMWGGlxTo0usdVAFkut+L2Fz6qHBFtTKVQ9TFTKN/XyFo0TIAFJR+zYI2BFb
	MhP/CXCGU4XPBkjx1HqQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ikDs1J0DF5pj2v5VnRsw8nC5xHt147jm8avpuSN/808=;
 b=PeBEWzINopbxSIEX8dTTnvGpTwR0bkiq7qfZm5a4PzcW2VN0u9ULY5aMLykSYvFwlReB
 qJtql6j6aLL4LBAfr3YSyzl8QrtnYeI7Ik9zjj2V8hTrlMScPSFYh7hOQmgPWcKq6ceQ
 g4MWTwRzACL/TfAfBkjQk5cRLy2tpRSpmVPAanLXnX6DirufMl/B8xqOlMr5OsTI/EOT
 dZJRZUgOC4HYAAomAbu3IJSdS83dtKxgqAYRSGTV0i9apZxEpS1kJoN5OTNreOKC9xL+
 ctAQA8a5HUzTQ7cQOxVQopHO95f5LAUAu5P8WQSJEpUHWh9/E1RjiGdgfsVUppbxZnx5 /Q== 
Content-Disposition: inline
In-Reply-To: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
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
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <>

On Tue, Oct 18, 2022 at 03:40:14PM +0800, Kefeng Wang wrote:
> Most architectures(except arm64/x86/sparc) simply return 1 for
> kern_addr_valid(), which is only used in read_kcore(), and it
> calls copy_from_kernel_nofault() which could check whether the
> address is a valid kernel address, so no need kern_addr_valid(),
> let's remove unneeded kern_addr_valid() completely.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
...
>  arch/s390/include/asm/pgtable.h           |  2 -

For s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
