From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 00/30] mm: remove bootmem allocator
Date: Wed, 26 Sep 2018 11:41:54 +0200
Message-ID: <20180926094154.GT6278@dhcp22.suse.cz>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Jonas Bonn <jonas@southpole.se>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <lftan@altera.com>, Mark Salter <msalter@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <p>

On Fri 14-09-18 15:10:15, Mike Rapoport wrote:
[...]
>  326 files changed, 866 insertions(+), 2539 deletions(-)
>  delete mode 100644 include/linux/bootmem.h
>  delete mode 100644 mm/bootmem.c
>  delete mode 100644 mm/nobootmem.c

I _really_ love this part the most! Not only we got rid of the
translation which always has been a headache but also this nicely shows
how having multiple allocators hurt. I believe further cleanups on top
will make the boot allocator even a place where you look and your eyes
do not want to jump out.

I have only went through patches without my acks from the previous
iteration and there are only minor comments. This looks good overall.

Nice work Mike!
-- 
Michal Hocko
SUSE Labs
