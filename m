From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH v2] hexagon: modify ffs() and fls() to return int
Date: Mon, 23 Jul 2018 18:31:06 -0500
Message-ID: <20180723233106.GD12771@codeaurora.org>
References: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
 <20180723225025.GC12771@codeaurora.org>
 <39ac5a3f-b5fa-a928-6caf-a7a01251f5ea@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532388669;
        bh=FvPmG4TIwWg8Cx5qQHofK9kEKxmFe6MT8oh2lOjySjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuOOyoxw5Vtaya76n1Pi77rvBxMMu1TrCpbLrw9DVQflGp5JERCiMfB7R38I2e5ty
         7km+CATuS1j9vsHdzF+BGvLDemsyfpMdhLu3/czN2hJ3QbmPmDIoPTUgydsk3AE8Rs
         FFN0PDQdu3Vc0f7PZkpVr90qcriT4r2K4D+IVVXk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532388668;
        bh=FvPmG4TIwWg8Cx5qQHofK9kEKxmFe6MT8oh2lOjySjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2wE1biVItExXMh/NcagTtZgTwCzFQQXnjW7cpr3LUKyGGwHIO1RcPXhCowFYI13i
         znp4NvhMNUrhY3epPC/v60/rGkmHvVVKl89nWbc63FhG7/+Nsdoyw4Jh5nTlsV65zb
         f/m+KkFD1qmb4SHLWPCsebs/om8+Mq6yo2ClWMuI=
Content-Disposition: inline
In-Reply-To: <39ac5a3f-b5fa-a928-6caf-a7a01251f5ea@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Mon, Jul 23, 2018 at 04:27:47PM -0700, Randy Dunlap wrote:
> On 07/23/2018 03:50 PM, Richard Kuo wrote:
> > On Sun, Jul 22, 2018 at 04:03:58PM -0700, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
> >> printk format build warning.  This is due to hexagon's ffs() being
> >> coded as returning long instead of int.
> >>
> >> Fix the printk format warning by changing all of hexagon's ffs() and
> >> fls() functions to return int instead of long.  The variables that
> >> they return are already int instead of long.  This return type
> >> matches the return type in <asm-generic/bitops/>.
> >>
> >> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
> >> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
> >>
> >> There are no ffs() or fls() allmodconfig build errors after making this
> >> change.
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Richard Kuo <rkuo@codeaurora.org>
> >> Cc: linux-hexagon@vger.kernel.org
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> ---
> >> v2:
> >> add hexagon contacts, drop erroneous sh contacts; [thanks, Geert]
> >> only change return type for ffs() and fls() [thanks, Geert]
> >>   [drop the changes for ffz(), __ffs(), and __fls()]
> >>
> >>  arch/hexagon/include/asm/bitops.h |    4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> > 
> > 
> > Acked-by: Richard Kuo <rkuo@codeaurora.org>
> > 
> 
> Hi Richard,
> 
> You are listed as the arch/hexagon/ maintainer.  Can you please merge these
> patches?
> 
> thanks,
> -- 
> ~Randy

Yes, I can queue it up and take it through my tree.


Thanks,
Richard Kuo


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
