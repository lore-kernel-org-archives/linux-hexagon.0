From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC DO NOT MERGE] treewide: use __xchg in most
 obvious places
Date: Tue, 10 Jan 2023 15:52:20 +0200
Message-ID: <Y71tlG23t0gH9K1t@smile.fi.intel.com>
References: <Y7b6/7coJEVlTVxK@phenom.ffwll.local>
 <20230110105306.3973122-1-andrzej.hajda@intel.com>
 <Y71G1tkmUzM4BLxn@smile.fi.intel.com>
 <1bfae3d0-8c0b-ea83-7184-db847a4a969f@intel.com>
Mime-Version: 1.0
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673358752; x=1704894752;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Tp8Z9Ay/HrlqQE0qDFK7p4Fost9+vU0ggkXvi/hfbkY=;
 b=kO8ox8CR+uhilfo5/X2nxkaV4R1ebPsPUWkdF4QsFnqdZi0+9yMqWhfv
 PKlzD1J/dYnz4SJUbaTjjtC0QteypDLuv9UL2ilJKOJseLb3blbbDRgKR
 /alyOqQ4wC48vEI6zM+ZbMmNStQiJjb/yC4L96pos2WPad5aLaWdyVG4l
 uSLI+r8CIVKKNrMjXpOdrBxFuVBLBGOGy9vjBUTE3wgpx9dSS06FYtC+A
 FnrdBVP/dZdOHbJka0bOPO00rFLSmTMw/1SY2fd3RmEgzglcdIq9JPESj
 +zfCtPa5XOVBH9lR3c6QkN7FDo4tDCyPTRSCV6yON/XMy6W476qcBtwWn A==;
Content-Disposition: inline
In-Reply-To: <1bfae3d0-8c0b-ea83-7184-db847a4a969f@intel.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org, intel-gfx@lists.freedesktop.org, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, loongarch@lists.linux.dev, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Tue, Jan 10, 2023 at 01:46:37PM +0100, Andrzej Hajda wrote:
> On 10.01.2023 12:07, Andy Shevchenko wrote:
> > On Tue, Jan 10, 2023 at 11:53:06AM +0100, Andrzej Hajda wrote:

...

> > > +	return __xchg(&p_chain->p_prod_elem,
> > > +		      (void *)(((u8 *)p_chain->p_prod_elem) + p_chain->elem_size));
> > 
> > Wondering if you still need a (void *) casting after the change. Ditto for the
> > rest of similar cases.
> 
> IMHO it is not needed also before the change and IIRC gcc has an extension
> which allows to drop (u8 *) cast as well [1].

I guess you can drop at least the former one.

> [1]: https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html

...

> > Btw, is it done by coccinelle? If no, why not providing the script?
> 
> Yes I have used cocci. My cocci skills are far from perfect, so I did not
> want to share my dirty code, but this is nothing secret:

Thank you! It's not about secrecy, it's about automation / error proofness.

-- 
With Best Regards,
Andy Shevchenko


