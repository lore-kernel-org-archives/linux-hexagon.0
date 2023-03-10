From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4 3/4] arch/*/io.h: remove ioremap_uc in some
 architectures
Date: Fri, 10 Mar 2023 09:45:28 +0800
Message-ID: <ZAqLuNrPng9i0rZV@MiWiFi-R3L-srv>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-4-bhe@redhat.com>
 <20230309143621.GA12350@alpha.franken.de>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678412740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtJkfRI7AXY3SogCgOFRi4FhIfSeTbcT8pIq6VJrULQ=;
	b=B/Af4ewnqokc6nwChI1Xe5A1cuFraLw70Kh4hkHWdDUzhSXkvy2x7qG8jbc9MjVGrL9FDG
	5QYZ/o8XgVm97anqDOgPU+5XBLZmZMuPR7GDjobicTAAGt+rnqFGOY8SQVKlH4/6SPVvPq
	DOXShZxth2zlGq3GaPRB+qKCxBBSoG0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678412740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtJkfRI7AXY3SogCgOFRi4FhIfSeTbcT8pIq6VJrULQ=;
	b=B/Af4ewnqokc6nwChI1Xe5A1cuFraLw70Kh4hkHWdDUzhSXkvy2x7qG8jbc9MjVGrL9FDG
	5QYZ/o8XgVm97anqDOgPU+5XBLZmZMuPR7GDjobicTAAGt+rnqFGOY8SQVKlH4/6SPVvPq
	DOXShZxth2zlGq3GaPRB+qKCxBBSoG0=
Content-Disposition: inline
In-Reply-To: <20230309143621.GA12350@alpha.franken.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, arnd@arndb.de, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, hch@infradead.org, linux-mm@kvack.org, mcgrof@kernel.org, geert@linux-m68k.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 03/09/23 at 03:36pm, Thomas Bogendoerfer wrote:
> On Wed, Mar 08, 2023 at 09:07:09PM +0800, Baoquan He wrote:
> > ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> > extension, and on ia64 with its slightly unconventional ioremap()
> > behavior. So remove the ioremap_uc() definition in architecutures
> > other than x86 and ia64. These architectures all have asm-generic/io.h
> > included and will have the default ioremap_uc() definition which
> > returns NULL.
> > 
> > This changes the existing behaviour, while no need to worry about
> > any breakage because in the only callsite of ioremap_uc(), code
> > has been adjusted to eliminate the impact. Please see
> > atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.
> > 
> > If any new invocation of ioremap_uc() need be added, please consider
> > using ioremap() intead or adding a ARCH specific version if necessary.
> > 
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: linux-alpha@vger.kernel.org
> > Cc: linux-hexagon@vger.kernel.org
> > Cc: linux-m68k@lists.linux-m68k.org
> > Cc: linux-mips@vger.kernel.org
> > Cc: linux-parisc@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-sh@vger.kernel.org
> > Cc: sparclinux@vger.kernel.org
> > ---
> >  Documentation/driver-api/device-io.rst | 9 +++++----
> >  arch/alpha/include/asm/io.h            | 1 -
> >  arch/hexagon/include/asm/io.h          | 3 ---
> >  arch/m68k/include/asm/kmap.h           | 1 -
> >  arch/mips/include/asm/io.h             | 1 -
> >  arch/parisc/include/asm/io.h           | 2 --
> >  arch/powerpc/include/asm/io.h          | 1 -
> >  arch/sh/include/asm/io.h               | 2 --
> >  arch/sparc/include/asm/io_64.h         | 1 -
> >  9 files changed, 5 insertions(+), 16 deletions(-)
> 
> this doesn't apply to v6.3-rc1... what tree is this based on ?

Sorry, I forgot mentioning this in cover letter. This series is
followup of below patchset, so it's on top of below patchset and based
on v6.3-rc1.

https://lore.kernel.org/all/20230301034247.136007-1-bhe@redhat.com/T/#u
[PATCH v5 00/17] mm: ioremap:  Convert architectures to take GENERIC_IOREMAP way

Thanks
Baoquan

