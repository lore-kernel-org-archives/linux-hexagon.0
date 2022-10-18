From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm: remove kern_addr_valid() completely
Date: Tue, 18 Oct 2022 01:09:38 -0700
Message-ID: <Y05fQrd4TYaOnks/@infradead.org>
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
	List-Owner; bh=HwGqZ9toBDeFCwIHDEGmMqRTs92OP8XJgF9OzL2iCxc=; b=QYWy3SsKYR5xj+
	MA93ePYjBrmU7auJH+x81sH1MxHQpuAsgTWuQGjFE32xh/Pqn0nTt3gwExEenXhJrZsXBPLj1Sbea
	lHqp9yg8nxraFsZ38qV5oYuTLDJ2187IztwbzMaAhPl4OYy++5/BsNhIcgc/kTzs3w680ImLL4Vg2
	ke0RgPmul1syH9AV/GvGy2vDNgWuGAuEIDLOUcRrsJrucckDNPhxODXxlEK25UpV4nQzGPzEGq36i
	eP7UuFW6s4GMMK9h29APHFUeGVxkHA1KzMNZYwKjbhGzEc7jhES8hnR+ZToltqjVyyxcDTGIlyB61
	cD1IGZBCuRUtrL79FZ+A==;
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marina>

Thanks, this is long overdue!

Acked-by: Christoph Hellwig <hch@lst.de>
