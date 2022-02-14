From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 04/14] x86: use more conventional access_ok() definition
Date: Mon, 14 Feb 2022 09:02:13 -0800
Message-ID: <YgqLFYqIqkIsNC92@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org>
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
	List-Owner; bh=8c01ri8ktpf/96JuXtVERGTiyQNpNCkJGphVw1611gQ=; b=ybCayvaCQP3X1L
	aXhDOR2TXt4p0dcIO8a1R8Y8bzj4Bs6zqCIMn9kwIf4m10NqqA9NCkpDs08dZF1GcPePXbbiAGL/B
	3dmW8nOUMCb0/ZvwQawRZfRxCb8oQVP38cd5EQMgaXlo2Huf4dZlIF3ZC370Y0x0ZC4q+v0dzjB45
	ejen3vXRjCcCUMn4+K2/4rhjvUxZFUr4al79I5DtJ5FEoMzNMRVQeXeU8ykEpvg5K+dNPEbewfTVv
	dzGT1hm2CfgIOIRyI5R0eOBq0zR3DbkOihtwSwV6QHFubHqNA0KTmNbhOr7wuJDPzprQT0WsZbTSL
	y/YgShrktgikWEQ2enZA==;
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-5-arnd@kernel.org>
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

On Mon, Feb 14, 2022 at 05:34:42PM +0100, Arnd Bergmann wrote:
> +#define __range_not_ok(addr, size, limit)	(!__access_ok(addr, size))
> +#define __chk_range_not_ok(addr, size, limit)	(!__access_ok((void __user *)addr, size))

Can we just kill these off insted of letting themm obsfucate the code?
