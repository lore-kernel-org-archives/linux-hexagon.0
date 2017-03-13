From: Till Smejkal <till.smejkal@googlemail.com>
Subject: Re: [RFC PATCH 11/13] mm/vas: Introduce VAS segments - shareable
 address space regions
Date: Mon, 13 Mar 2017 15:45:36 -0700
Message-ID: <20170313224536.saqdijtdayxwmlpz@arch-dev>
References: <20170313222758.GB4033@bombadil.infradead.org>
Mime-Version: 1.0
Return-path: <owner-linux-aio@kvack.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=obqr0DX1/kdLIbymNY1r8hEPwuhD6CNhDknDx2xbFbA=;
        b=fuy5BgdoB+/FuVYdufqmKyuyKGfwGt7XoNg4q02V9RMGKVJC40ke0vVjbGkLfdr0AD
         aQWsqFKuGZ+l24NxOa1U6vsIDkXIEJ2hbIdVWFOvFJYF5TmW960pw7sD/cIuUX8npeX4
         oEEFhjhlf62XHcyA6iQXyUy0p0BEZUcJZqnX6YCLkVf3ka2wOeltt4lXCS303HHdUu7f
         1WxnSkJGqESSQAGXb1wKi/wJr7ClJlelA15ftj4gWwYrD+t5v4HS/ReZfuZe7PUn84n5
         Tmqfw9x+QdthZ440v4SZ3krSoBC0DYI9WI0I1DFsRDFGMD7enniLFgBVz198rlKb5fJU
         oizw==
Content-Disposition: inline
In-Reply-To: <20170313222758.GB4033@bombadil.infradead.org>
Sender: owner-linux-aio@kvack.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Till Smejkal <till.smejkal@googlemail.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalia>

Hi Matthew,

On Mon, 13 Mar 2017, Matthew Wilcox wrote:
> On Mon, Mar 13, 2017 at 03:14:13PM -0700, Till Smejkal wrote:
> > +/**
> > + * Create a new VAS segment.
> > + *
> > + * @param[in] name:		The name of the new VAS segment.
> > + * @param[in] start:		The address where the VAS segment begins.
> > + * @param[in] end:		The address where the VAS segment ends.
> > + * @param[in] mode:		The access rights for the VAS segment.
> > + *
> > + * @returns:			The VAS segment ID on success, -ERRNO otherwise.
> > + **/
> 
> Please follow the kernel-doc conventions, as described in
> Documentation/doc-guide/kernel-doc.rst.  Also, function documentation
> goes with the implementation, not the declaration.

Thank you for this pointer. I wasn't aware of this convention. I will change the
patches accordingly.

> > +/**
> > + * Get ID of the VAS segment belonging to a given name.
> > + *
> > + * @param[in] name:		The name of the VAS segment for which the ID
> > + *				should be returned.
> > + *
> > + * @returns:			The VAS segment ID on success, -ERRNO
> > + *				otherwise.
> > + **/
> > +extern int vas_seg_find(const char *name);
> 
> So ... segments have names, and IDs ... and access permissions ...
> Why isn't this a special purpose filesystem?

We also thought about this. However, we decided against implementing them as a
special purpose filesystem, mainly because we could not think of a good way to
represent a VAS/VAS segment in this file system (should they be represented rather as
file or directory) and we weren't sure what a hierarchy in the filesystem would mean
for the underlying address spaces. Hence we decided against it and rather used a
combination of IDR and sysfs. However, I don't have any strong feelings and would
also reimplement them as a special purpose filesystem if people rather like them to
be one.

Till

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
