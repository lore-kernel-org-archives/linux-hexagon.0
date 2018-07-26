From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH v2] hexagon: switch to NO_BOOTMEM
Date: Wed, 25 Jul 2018 20:44:57 -0500
Message-ID: <20180726014457.GH12771@codeaurora.org>
References: <1532496594-26353-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532569500;
        bh=uw50wi2FW31v8GsHzM4FK1Wn0Li8mrNElKlsY3Pspbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsXLSIH4PIalvaJdIwvZP0tV2Pkh2wqnIf9HISPUAyw9nR74AqIY47r2hkfHisPnT
         H6NenKdZSLqxBtkZXPcOblbXTvYdVQAoeIDpPQ6p2JtYrnoD0sMditLZ/jOTr4MQg5
         KmEtSy/VONOo4eK3E4nqLX3ZmcPRJqbvnlHbO4og=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532569499;
        bh=uw50wi2FW31v8GsHzM4FK1Wn0Li8mrNElKlsY3Pspbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXs+FbL9qJIDvwdKy0U3TCPfC2v0CfvvZuEnrQkyuMnAHnEuDDl9p4wbqN1Bx9O3q
         WMHIqCmQFwlRIn2k61FvQiL3tXPy0vPhmNZDjIaB9z5fwQceiTaY8cxQ7PwuKr/6Lr
         p2Xa1zwWvHTpFJ7RYJ+4gEru72OOEJ1OFl6Z+d5M=
Content-Disposition: inline
In-Reply-To: <1532496594-26353-1-git-send-email-rppt@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:29:54AM +0300, Mike Rapoport wrote:
> This patch adds registration of the system memory with memblock, eliminates
> bootmem initialization and converts early memory reservations from bootmem
> to memblock.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
> v2: fix calculation of the reserved memory size
> 
>  arch/hexagon/Kconfig   |  3 +++
>  arch/hexagon/mm/init.c | 20 ++++++++------------
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 

Looks good, I can take this through my tree.


Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
