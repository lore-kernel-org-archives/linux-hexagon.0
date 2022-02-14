From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 07/14] uaccess: generalize access_ok()
Date: Mon, 14 Feb 2022 09:04:44 -0800
Message-ID: <YgqLrB5LttWFIScK@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-8-arnd@kernel.org>
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
	List-Owner; bh=fKnPFlKV9ni1gXrqbIys/Lwum8qfOVQrgXNQOBioFHc=; b=3ikDoRt2Aeuw0h
	xQg6IiR/yVknp+mW5oB4hdVYERb10DUXELHAga2wwGAU+95uu7XsfKOIIYmSvA/ziTtZ1h+nSd4YK
	44UCL1EL7uBmJd2cCcG3NDXsF+rhQH2Y9ZKx3dk2RCVA7vxnalQurHCY9kq6OaP5+JTWii4JgVrGO
	SQb4UA92DX3Tm7A+5onZv6SMCkeCFY5diMeJ1Y/E28VmfCywd22E4SNlrIBSNN8E9kYA0DoN8aGT7
	IBZeqkC0qZXFWQ6LpS4EhrH5CnZTRD/OpPPUkLAUk7srOpACylfOsBmQ6144CQ5m4SGWkgCt84g1R
	aE7mWbtQAiBg7lJwpSUA==;
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-8-arnd@kernel.org>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
