From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/26] mips: remove ioremap_cachable
Date: Fri, 30 Aug 2019 18:06:35 +0200
Message-ID: <20190830160635.GE26887@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-5-hch@lst.de>
 <20190819205722.4eir2edy6qgtgarl@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AvHUE9Unk2bN1KkeDclVMwOtpW6cjVXFFPcmJ/MvX+4=; b=CxsSuNms3XUVMF
	smSbtkUCRitV4bwCQpIQSKwgRMfIQo48sWlZ9YwHDL+qm1tweE7vmZjyomhYrE6PL/d6fO7y89tyR
	alYg6sQmXuTjt4qxpa7O559a4iOTal5RJQvY2OaFZYVOs7dnUxqbVl8IMrEZz7EdO6Ak1H799eoip
	Wrf+Qe5HyKt0cvpgzedNhGmoQkNWLrHwFJV6KArDJfN7k1YT47eMlgwfalxxFBpIoq8crEubqEEeW
	JSXWme2MJS3AWshT++8gdwWp2QE55BD+jEyFB/by16edZP5W44FeUcFRLleO5lbfIvX7+F22YAccK
	udH/5dD82tgarH4+FdHA==;
Content-Disposition: inline
In-Reply-To: <20190819205722.4eir2edy6qgtgarl@pburton-laptop>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Burton <paul.burton@mips.com>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Guo Ren <guoren@kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Vincent Chen <deanbo422@gmail.com>, Christoph Hellwig <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Arnd Bergmann <arnd@arndb.de>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, Greentime Hu <green>

On Mon, Aug 19, 2019 at 08:57:30PM +0000, Paul Burton wrote:
> Hi Christoph,
> 
> On Sat, Aug 17, 2019 at 09:32:31AM +0200, Christoph Hellwig wrote:
> > Just define ioremap_cache directly.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Paul Burton <paul.burton@mips.com>

Can you pick this patch up through the mips tree?
