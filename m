From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 19/26] arm64: remove __iounmap
Date: Mon, 19 Aug 2019 08:36:02 +0100
Message-ID: <20190819073601.4yxjvmyjtpi7tk56@willie-the-truck>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-20-hch@lst.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566200169;
        bh=kEBAsv6X4r+CES0f8/n93x03kus6b78gzWZGhEXZpw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZN3P1/69MIOg2B81SBINNz+rGfKhZFusbOaGyLqQb9Blsv2mSti1MWTsa90w0MESp
         jadhaU0lZuPw9eWpwjH+XOFMUB/Sje+alD+6KyK2Fb4eskV8ocTyIHvbtygC57mPxu
         nNYqk608qsL0SWijHJgztgoabuo0beTwpG+bcwSU=
Content-Disposition: inline
In-Reply-To: <20190817073253.27819-20-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 09:32:46AM +0200, Christoph Hellwig wrote:
> No need to indirect iounmap for arm64.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/io.h | 3 +--
>  arch/arm64/mm/ioremap.c     | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Not sure why we did it like this...

Acked-by: Will Deacon <will@kernel.org>

Will
