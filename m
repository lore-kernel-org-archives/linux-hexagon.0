From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH v2] hexagon: modify ffs() and fls() to return int
Date: Mon, 23 Jul 2018 17:50:25 -0500
Message-ID: <20180723225025.GC12771@codeaurora.org>
References: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532386228;
        bh=/Br1l6yKPHuuaxyYd5Mx2l52sdBHt6nau3QvIsxH1zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a43yuFq6bYwejMEOvwrqyPTQxSxOv+QU2j1p9d+YnlGbfCV2VU38rHgvKWluOE/K9
         +edK1mIDINug260n10SOPmzCk7f6GbVy5xHrkDls/cSiZeH585CuzE02/aFkjL46pH
         Mob60scjPngoaNyOB2JoVwkB8qXXNFqVxRdTHrVI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532386227;
        bh=/Br1l6yKPHuuaxyYd5Mx2l52sdBHt6nau3QvIsxH1zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ap4S/upUYPeqbFCLrnq8ls7yOips/pBnwel0s7Osq9/EYGXfijG+eR2kX7jgB77tj
         3eRt7Nxhz9PynKQyg/IFxOp8wnYwvTunR3t7WxMhVTdjCxZevdPCSrpeYeOeR1H0vv
         ySpF4Po7S5kzs7MiKxUvKRqKyhQyuM78JIlbkkyw=
Content-Disposition: inline
In-Reply-To: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Sun, Jul 22, 2018 at 04:03:58PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
> printk format build warning.  This is due to hexagon's ffs() being
> coded as returning long instead of int.
> 
> Fix the printk format warning by changing all of hexagon's ffs() and
> fls() functions to return int instead of long.  The variables that
> they return are already int instead of long.  This return type
> matches the return type in <asm-generic/bitops/>.
> 
> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
> 
> There are no ffs() or fls() allmodconfig build errors after making this
> change.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
> add hexagon contacts, drop erroneous sh contacts; [thanks, Geert]
> only change return type for ffs() and fls() [thanks, Geert]
>   [drop the changes for ffz(), __ffs(), and __fls()]
> 
>  arch/hexagon/include/asm/bitops.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
