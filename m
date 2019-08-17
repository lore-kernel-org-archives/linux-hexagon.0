From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 12/26] x86: clean up ioremap
Date: Sat, 17 Aug 2019 12:34:02 +0200
Message-ID: <20190817103402.GA7602@gmail.com>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-13-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3rsiVG2c/RtTKsJF5qs6XYnONYlqH/o8BFcauqxhQ/Q=; b=el+bJ4jVpOZfG/
	VpGa4zEz6dBG6+mku3QrP3NvrW9GJ9RI7n93c6CgdQI7oX8JXxcJ65Zf9YvCaAM5ea8WDvxzx/A8a
	ejP/HrZvlWc2q3ocLfZVA7uDb+RGucJz5OgNNOKvghAofqyoswC0JtoSdWSAnWqkJVmbpDvUYX9hS
	8s7uAl7gpmlpkkEbQxeAu8uDFXyfdguam626egMVJo3llrrraTbnYXguHFB/0OLfEwWb4ybg3jm8W
	N3zHy1aBvoK5oWpOyN0fphkHzK3a9t56AIorR/ooSo15Qw90ayve/ysFmCJOoXOtd+uwOGEUMjgMn
	8GLvuU4GpGQadeDIL6Zg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=39YvwnXSLPYPPS8HyY6xQ0pEYqQsaSVOcIZxY6QaSy0=;
 b=HaU5j73Xl18SPfWIKR/l5s1id63iaB7lpk2eLE9Cv93RaSr0QygCeb8VtdrjK/DFoH
 BzanBzeDzwH/CfWIayA254C8bK/pzQhAr1B+Cx1TRlWNSkT4XCzZLK+D58uxuJj/Z6c8
 1+jn+z+dU7Ewi0li9IwJ7jmFgqXABsf3p+TxQXzA7fHIgWlPmx739auC7j/bqLC+8NoU
 C3XDYz8eetWLerWT9nDLSd3eyiPofE72zfZEgyCEmcNmd7KEx0oxertXb8lLCukZQpFv
 6wFercfLlPzs2ZP2Iysl6A4A+S9cPkEPkEAEiZMttS1pDBUiq7OyBBL/XEMk2UGfKSWg
 tAUQ==
Content-Disposition: inline
In-Reply-To: <20190817073253.27819-13-hch@lst.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-mtd@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org


* Christoph Hellwig <hch@lst.de> wrote:

> Use ioremap as the main implemented function, and defined
> ioremap_nocache to it as a deprecated alias.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/io.h | 8 ++------
>  arch/x86/mm/ioremap.c     | 8 ++++----
>  arch/x86/mm/pageattr.c    | 4 ++--
>  3 files changed, 8 insertions(+), 12 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
