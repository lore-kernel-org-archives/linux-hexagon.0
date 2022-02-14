From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
Date: Mon, 14 Feb 2022 09:06:53 -0800
Message-ID: <YgqMLYJs0RMecMck@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-12-arnd@kernel.org>
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
	List-Owner; bh=hSn/DIH3OO1eOxNw6Y5R+MmjMxjCM9jTx0q13q4YfQo=; b=nLUrd7ePI1a5Rj
	3B7a+zEV8VD1yLPHAYcTRLuJcuPj4YER82tVnfkaSZSztbDe2iRWFLVZ6NovEoY98ySfeaKuJDZcl
	eBzcEcuzi/sC+4spwdp6ebm4pN7MPNu7z+OaEa7y5klr4Oce1DeeREuJzlVQOfzqocF5YvpZ1tuRc
	p7Witkj03hc52mUAXkIu3h+hV8X9xI8Rui5PgqhBb7Mx/Ur7+9YOU0BCkpdZruCISZBLVdVmzmD6S
	7AeVJ6nB+K0iGGDWU9Mv/Yl0CU02ZTUbwMrfwdfpefyrDGMDUzT8pqCZ/m4W1CSgizqTI9N/M4i99
	DErr13lk54x/11LGNbfA==;
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-12-arnd@kernel.org>
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
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, mark.rutland@arm.com, dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, jcmvbkbc@gmail.com, guoren@kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, will@kernel.org, ardb@kernel.org, linux-s390@vger.kernel.org, bcain@codeaurora.org, deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@redhat.com, geert@linux-m68k.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, hca@linux.ibm.com, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, green.hu@gmail.com, s

>  void prom_world(int enter)
>  {
> -	if (!enter)
> -		set_fs(get_fs());
> -
>  	__asm__ __volatile__("flushw");
>  }

The enter argument is now unused.
