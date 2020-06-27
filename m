From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/8] mm: cleanup usage of <asm/pgalloc.h>
Date: Sat, 27 Jun 2020 19:31:10 +0100
Message-ID: <20200627183110.GE25039@casper.infradead.org>
References: <20200627143453.31835-1-rppt@kernel.org>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iUonY5tAtTgjqNbCWE5Vwbj85TqSh1tjYug5m+z4Qck=; b=MsYzlS2SipjcxBXS/jfM5VXHva
        0MfNKJEN4Ox+ZUvZVKPtEzNZ/zLlCXy8jbjH80IN8Oo773ZG+LOVNciLsZ72OHXVwzxk8wniA3U0V
        tIoFs0GZReQhvgYWkbnVwL19Dtx67F+f2/O0c4xdQPIiDKuRbrQdIabEJGQ0UH7dl9YfrpBoHiVgY
        LJn5cith0pkJo77B4FDd/wIbqvCKQwOqO7uUuO1u9O+wrbWAQz/Co4K78ZNVlmHwzVD0Tbj5ZR3ox
        rEf/WEDcRKl4UkREWSDVjoOd6pfKJAywWo3Lu/yQzI4vCUWY3bSD+SM2sePDqJoJZXsfpfI+PBruY
        O/fqA5KQ==;
Content-Disposition: inline
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Joerg Roedel <joro@8bytes.org>, Max Filippov <jcmvbkbc@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Stafford Horne <shorne@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mi

On Sat, Jun 27, 2020 at 05:34:45PM +0300, Mike Rapoport wrote:
> Most architectures have very similar versions of pXd_alloc_one() and
> pXd_free_one() for intermediate levels of page table. 
> These patches add generic versions of these functions in
> <asm-generic/pgalloc.h> and enable use of the generic functions where
> appropriate.

For the series:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
