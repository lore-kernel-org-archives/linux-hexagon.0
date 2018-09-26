From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 14/30] memblock: add align parameter to
 memblock_alloc_node()
Date: Wed, 26 Sep 2018 11:36:48 +0200
Message-ID: <20180926093648.GP6278@dhcp22.suse.cz>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-15-git-send-email-rppt@linux.vnet.ibm.com>
 <20180926093127.GO6278@dhcp22.suse.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926093127.GO6278@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Jonas Bonn <jonas@southpole.se>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <lftan@altera.com>, Mark Salter <msalter@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <p>

On Wed 26-09-18 11:31:27, Michal Hocko wrote:
> On Fri 14-09-18 15:10:29, Mike Rapoport wrote:
> > With the align parameter memblock_alloc_node() can be used as drop in
> > replacement for alloc_bootmem_pages_node() and __alloc_bootmem_node(),
> > which is done in the following patches.
> 
> /me confused. Why do we need this patch at all? Maybe it should be
> folded into the later patch you are refereing here?

OK, I can see 1536927045-23536-17-git-send-email-rppt@linux.vnet.ibm.com
now. If you are going to repost for whatever reason please merge those
two. Also I would get rid of the implicit "0 implies SMP_CACHE_BYTES"
behavior. It is subtle and you have to dig deep to find that out. Why
not make it explicit?
-- 
Michal Hocko
SUSE Labs
