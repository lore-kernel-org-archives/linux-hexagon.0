From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] hexagon: switch to NO_BOOTMEM
Date: Wed, 25 Jul 2018 08:28:09 +0300
Message-ID: <20180725052809.GA25188@rapoport-lnx>
References: <1531726998-10971-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180723212339.GA12771@codeaurora.org>
 <20180724054704.GA16933@rapoport-lnx>
 <20180725021255.GF12771@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180725021255.GF12771@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:12:55PM -0500, Richard Kuo wrote:
> On Tue, Jul 24, 2018 at 08:47:04AM +0300, Mike Rapoport wrote:
> > On Mon, Jul 23, 2018 at 04:23:39PM -0500, Richard Kuo wrote:
> > > 
> > > On Mon, Jul 16, 2018 at 10:43:18AM +0300, Mike Rapoport wrote:
> > > > This patch adds registration of the system memory with memblock, eliminates
> > > > bootmem initialization and converts early memory reservations from bootmem
> > > > to memblock.
> > > > 
> > > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > > 
> > > Sorry for the delay, and thanks for this patch.
> > > 
> > > I think the first memblock_reserve should use ARCH_PFN_OFFSET instead of
> > > PHYS_OFFSET.
> > 
> > memblock_reserve gets physical address rather than a pfn.
> > 
> > If I read arch/hexagon/include/asm/mem-layout.h correctly, the PHYS_OFFSET
> > *is* the physical address of the RAM and ARCH_PFN_OFFSET is the first pfn:
> > 
> > #define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
> > #define ARCH_PFN_OFFSET	PHYS_PFN_OFFSET
> > 
> > Did I miss something?
> 
> Sorry, I should have been more clear.  In the size calculation, it's
> subtracting the unshifted PHYS_OFFSET from the start page number, which
> I'm pretty sure is wrong.

Yeah, you're right. I've missed that one.
 
> Thanks,
> Richard Kuo
> 
> 
> -- 
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
> a Linux Foundation Collaborative Project
> 

-- 
Sincerely yours,
Mike.

