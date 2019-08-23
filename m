From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 05/26] openrisc: map as uncached in ioremap
Date: Fri, 23 Aug 2019 22:55:39 +0900
Message-ID: <20190823135539.GC24874@lianli.shorne-pla.net>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-6-hch@lst.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BUAiw1OCmJxcFhDfFwk6vJ4atOusYa0enlexPK5RdcM=;
        b=p1kpl17yQ70OZJjj0Ex1dhmfo2/01ZSY1fOdxj+J/0LKK1tvqbyWGApNp+RopSCBU9
         F4JDgPHlcLiS1iW8iLa6+Oz3hvJ93YLeeZOw8VI/PWR7yXZkQ2Y3BWj/9xw0zvYm8PgM
         xCORxywfStYr2iObddDIvw4uxyyFDzJ4nH8mOJxihZGgGGvOFtqX5rLKfVLumbHnUiDf
         cp+XG0kMNbLUq5HT5W+hUh/PxuwaBDz2hVRJ6ISjeckQ/denHk7F5JHtEBhHBSkgw5OY
         5pVQ0XdibEupNYaM8DhPTT4HkPLbYUHv2fszhaDZIjemQ/II2oo6OpoSBdKla1hplbzS
         Zchg==
Content-Disposition: inline
In-Reply-To: <20190817073253.27819-6-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 09:32:32AM +0200, Christoph Hellwig wrote:
> Openrisc is the only architecture not mapping ioremap as uncached,
> which has been the default since the Linux 2.6.x days.  Switch it
> over to implement uncached semantics by default.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/openrisc/include/asm/io.h      | 20 +++-----------------
>  arch/openrisc/include/asm/pgtable.h |  2 +-
>  arch/openrisc/mm/ioremap.c          |  8 ++++----
>  3 files changed, 8 insertions(+), 22 deletions(-)

Acked-by: Stafford Horne <shorne@gmail.com>

Thanks,
 -Stafford 
