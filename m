From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] hexagon: switch to NO_BOOTMEM
Date: Thu, 26 Jul 2018 07:13:54 +0300
Message-ID: <20180726041353.GA8477@rapoport-lnx>
References: <1532496594-26353-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726014457.GH12771@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180726014457.GH12771@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:44:57PM -0500, Richard Kuo wrote:
> On Wed, Jul 25, 2018 at 08:29:54AM +0300, Mike Rapoport wrote:
> > This patch adds registration of the system memory with memblock, eliminates
> > bootmem initialization and converts early memory reservations from bootmem
> > to memblock.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> > v2: fix calculation of the reserved memory size
> > 
> >  arch/hexagon/Kconfig   |  3 +++
> >  arch/hexagon/mm/init.c | 20 ++++++++------------
> >  2 files changed, 11 insertions(+), 12 deletions(-)
> > 
> 
> Looks good, I can take this through my tree.
 
Thanks. The hexagon tree seems the most appropriate :)
 
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 

-- 
Sincerely yours,
Mike.

