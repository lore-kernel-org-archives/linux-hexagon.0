From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon: switch to NO_BOOTMEM
Date: Mon, 23 Jul 2018 16:23:39 -0500
Message-ID: <20180723212339.GA12771@codeaurora.org>
References: <1531726998-10971-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532381022;
        bh=zbmcGenh7u4IUfo6j15YwY5GONflaYMxLonmvytXGQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiHeBxZMDhxOsB5yFAQ/CRdNkg5AB10ov5mvM4SdJA1mtemz306iBL2BW6wLmwvyM
         5ps6OCMewyXyEDDAWD25loixihj9LXp0kM0/GwDUP0eqUzst5+31SPN25CjOsfLya+
         ffeeNWh8CJrhex2e0NM2DJCzReYAduQ/uRSYQN+A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532381022;
        bh=zbmcGenh7u4IUfo6j15YwY5GONflaYMxLonmvytXGQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiHeBxZMDhxOsB5yFAQ/CRdNkg5AB10ov5mvM4SdJA1mtemz306iBL2BW6wLmwvyM
         5ps6OCMewyXyEDDAWD25loixihj9LXp0kM0/GwDUP0eqUzst5+31SPN25CjOsfLya+
         ffeeNWh8CJrhex2e0NM2DJCzReYAduQ/uRSYQN+A=
Content-Disposition: inline
In-Reply-To: <1531726998-10971-1-git-send-email-rppt@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org


On Mon, Jul 16, 2018 at 10:43:18AM +0300, Mike Rapoport wrote:
> This patch adds registration of the system memory with memblock, eliminates
> bootmem initialization and converts early memory reservations from bootmem
> to memblock.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Sorry for the delay, and thanks for this patch.

I think the first memblock_reserve should use ARCH_PFN_OFFSET instead of
PHYS_OFFSET.

If you can amend that I'd be happy to take it through my tree or it can go
through any other.


Thanks,
Richard Kuo


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
