From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 07/30] memblock: remove _virt from APIs returning virtual
 address
Date: Wed, 26 Sep 2018 11:27:54 +0200
Message-ID: <20180926092754.GN6278@dhcp22.suse.cz>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-8-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536927045-23536-8-git-send-email-rppt@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Jonas Bonn <jonas@southpole.se>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <lftan@altera.com>, Mark Salter <msalter@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <p>

On Fri 14-09-18 15:10:22, Mike Rapoport wrote:
> The conversion is done using
> 
> sed -i 's@memblock_virt_alloc@memblock_alloc@g' \
> 	$(git grep -l memblock_virt_alloc)
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

As I've said earlier, I am not entirely thrilled by this change. It is
unnecessary churn. So if nothing else just add a note _why_ you think
this is better.
-- 
Michal Hocko
SUSE Labs
