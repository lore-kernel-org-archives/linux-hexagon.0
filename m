Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921A47F64;
	Fri,  2 Aug 2024 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722637194; cv=none; b=uI9lhhPp86h1EyLCq2svqF1Fc2rMs1kbfTI2aNmTUR84/FecGrvpTgEkaqdfnBbm8isA134Kc1dkIDz8exDpuO7gwLtVAu0Ge/Xyo4Y+GyNRtT2U+0Q88avlEEvgAQxpauIKgSffBDr5LtoGHzWttTbie8ykYcD+Un9szst7Vws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722637194; c=relaxed/simple;
	bh=mcxSg+qGadL76KNrl2hpaR9JR+cq+JmpnzMW4vQqLJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5U/9UnUuS0KSi2kZIPmIJ2QN2KtVVXOdGWPHtOqQbMjZbgMByJdk6dU5kzVGe9pcZrNBfrQn3Wwd6qxoqqe16RMEZTFcq8MSM93x0LAqNTsHQvvE3JdvafxN8o9yXqym8li9jAr5vrjMJHWvs4EUCx2o/w1B+0ZZRQbUY8Bs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axS8BAGd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axS8BAGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADC5C32782;
	Fri,  2 Aug 2024 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722637194;
	bh=mcxSg+qGadL76KNrl2hpaR9JR+cq+JmpnzMW4vQqLJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axS8BAGdIKBBiJOnu35QVEQ1ct0UdlZxaDkc6OsnMxIFpMVmuJPfSkjj7HisuhCTK
	 LNgr5LvYCdNJYCe1iqm7wpR0fKl5FGLBsKLhE36Yq1rCWlh/8dfM8saGqJDDt0szrs
	 gmbUTyrY3SlMT/dpkvlwBnRKtqmibUv29JjaHf3jSv9ryI1uK4XJrtdw1RwyAnD8JO
	 dV6z+4pFx/BCgNdJYVurZMnTdmNhu0buBTKl7SZjLKKUL7KXYnkVSOk5lqiqpKUAQN
	 /0l2LhhveEFRb64g28x/HUKtm/rT4dWcJLIehaLMv0x+td41hAYDTiONTQJFGtvAIa
	 Ffyq+WDpzEQOw==
Date: Fri, 2 Aug 2024 15:19:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: kernel test robot <lkp@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of
 struct_group_tagged()
Message-ID: <20240802221952.GA737452@thelio-3990X>
References: <202408011956.wscyBwq6-lkp@intel.com>
 <138da3e5-0e24-41a6-bb35-df5d07045eb3@embeddedor.com>
 <20240801190813.GC122261@thelio-3990X>
 <f40160aa-7cbd-4264-be44-45396b09574f@embeddedor.com>
 <20240801221427.GA3773553@thelio-3990X>
 <ca056227-30c3-47b9-a19a-fbab87778f20@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca056227-30c3-47b9-a19a-fbab87778f20@embeddedor.com>

On Thu, Aug 01, 2024 at 04:35:59PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 01/08/24 16:14, Nathan Chancellor wrote:
> > On Thu, Aug 01, 2024 at 02:17:50PM -0600, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 01/08/24 13:08, Nathan Chancellor wrote:
> > > > On Thu, Aug 01, 2024 at 06:47:58AM -0600, Gustavo A. R. Silva wrote:
> > > > > 
> > > > > 
> > > > > On 01/08/24 05:35, kernel test robot wrote:
> > > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc-2
> > > > > > head:   df15c862c1b93b6e1f6c90b0d7971f7a6ad66751
> > > > > > commit: e7cd9f429a852fb7e37a706c7d08fc36e7863e06 [11/18] RDMA/uverbs: Use static_assert() to check struct sizes
> > > > > > config: hexagon-randconfig-001-20240801 (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/config)
> > > > > > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 430b90f04533b099d788db2668176038be38c53b)
> > > > > 
> > > > > 
> > > > > Clang 20.0.0?? (thinkingface)
> > > > 
> > > > Indeed, Clang 19 branched and main is now 20 :)
> > > > 
> > > > https://github.com/llvm/llvm-project/commit/8f701b5df0adb3a2960d78ca2ad9cf53f39ba2fe
> > > 
> > > Yeah, but is that a stable release?
> > 
> > No, but the Intel folks have tested tip of tree LLVM against the kernel
> > for us for a few years now to try and catch issues such as this.
> 
> Oh, I see, fine. :)
> 
> > 
> > > BTW, I don't see GCC reporting the same problem below:
> > 
> > Hexagon does not have a GCC backend anymore so it is not going to be
> > possible to do an exact A/B comparison with this configuration but...
> > 
> > > > > > > > include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()
> > > > > >         643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
> > > > > >             | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >         644 |               "struct member likely outside of struct_group_tagged()");
> > > > > >             |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >       include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
> > > > > >          16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
> > > > > >             |                                 ^
> > > > > >       include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
> > > > > >          77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> > > > > >             |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >       include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
> > > > > >          78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> > > > > >             |                                                        ^~~~
> > > > > >       include/rdma/uverbs_ioctl.h:643:58: note: expression evaluates to '56 == 52'
> > 
> > This seems to give some indication that perhaps there may be some
> > architecture specific here with padding maybe? I seem to recall ARM OABI
> > having something similar. Adding the Hexagon folks/list to get some more
> > clarification. Full warning and context:
> > 
> > https://lore.kernel.org/202408011956.wscyBwq6-lkp@intel.com/
> > 
> > The problematic section preprocessed since sometimes the macros
> > obfuscate things:
> > 
> > struct uverbs_attr_bundle {
> >          union {
> >                  struct {
> >                          struct ib_udata driver_udata;
> >                          struct ib_udata ucore;
> >                          struct ib_uverbs_file *ufile;
> >                          struct ib_ucontext *context;
> >                          struct ib_uobject *uobject;
> >                          unsigned long attr_present[(((UVERBS_API_ATTR_BKEY_LEN) +
> >                                                       ((sizeof(long) * 8)) - 1) /
> >                                                      ((sizeof(long) * 8)))];
> >                  };
> >                  struct uverbs_attr_bundle_hdr {
> >                          struct ib_udata driver_udata;
> >                          struct ib_udata ucore;
> >                          struct ib_uverbs_file *ufile;
> >                          struct ib_ucontext *context;
> >                          struct ib_uobject *uobject;
> >                          unsigned long attr_present[(((UVERBS_API_ATTR_BKEY_LEN) +
> >                                                       ((sizeof(long) * 8)) - 1) /
> >                                                      ((sizeof(long) * 8)))];
> >                  } hdr;
> >          };
> > 
> >          struct uverbs_attr attrs[];
> > };
> > _Static_assert(__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
> >                         sizeof(struct uverbs_attr_bundle_hdr),
> >                 "struct member likely outside of struct_group_tagged()");
> > 
> > FWIW, I see this with all versions of Clang that the kernel supports
> > with this configuration.
> 
> I don't have access to a Clang compiler right now; I wonder if you could
> help me get the output of this command:
> 
> pahole -C uverbs_attr_bundle drivers/infiniband/core/rdma_core.o

We disabled CONFIG_DEBUG_INFO_BTF for Hexagon because elfutils does not
support Hexagon relocations but this is built-in for this configuration
so I removed that limitation and ended up with:

$ pahole -C uverbs_attr_bundle vmlinux
struct uverbs_attr_bundle {
        union {
                struct {
                        struct ib_udata driver_udata;    /*     0    16 */
                        struct ib_udata ucore;           /*    16    16 */
                        struct ib_uverbs_file * ufile;   /*    32     4 */
                        struct ib_ucontext * context;    /*    36     4 */
                        struct ib_uobject * uobject;     /*    40     4 */
                        unsigned long attr_present[2];   /*    44     8 */
                };                                       /*     0    52 */
                struct uverbs_attr_bundle_hdr hdr;       /*     0    52 */
        };                                               /*     0    52 */

        /* XXX 4 bytes hole, try to pack */
        union {
                struct {
                        struct ib_udata    driver_udata;         /*     0    16 */
                        struct ib_udata    ucore;                /*    16    16 */
                        struct ib_uverbs_file * ufile;           /*    32     4 */
                        struct ib_ucontext * context;            /*    36     4 */
                        struct ib_uobject * uobject;             /*    40     4 */
                        unsigned long      attr_present[2];      /*    44     8 */
                };                                               /*     0    52 */
                struct uverbs_attr_bundle_hdr hdr;               /*     0    52 */
        };


        struct uverbs_attr         attrs[];              /*    56     0 */

        /* size: 56, cachelines: 1, members: 2 */
        /* sum members: 52, holes: 1, sum holes: 4 */
        /* last cacheline: 56 bytes */
};

If you want any other information or want me to test anything, I am more
than happy to do so.

Cheers,
Nathan

> > > > > >         643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
> > > > > >             | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >         644 |               "struct member likely outside of struct_group_tagged()");
> > > > > >             |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >       include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
> > > > > >          77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> > > > > >             |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >       include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
> > > > > >          78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> > > > > >             |                                                        ^~~~
> > > > > >       7 warnings and 1 error generated.
> > > > > > 
> > > > > > 
> > > > > > vim +643 include/rdma/uverbs_ioctl.h
> > > > > > 
> > > > > >       630	
> > > > > >       631	struct uverbs_attr_bundle {
> > > > > >       632		/* New members MUST be added within the struct_group() macro below. */
> > > > > >       633		struct_group_tagged(uverbs_attr_bundle_hdr, hdr,
> > > > > >       634			struct ib_udata driver_udata;
> > > > > >       635			struct ib_udata ucore;
> > > > > >       636			struct ib_uverbs_file *ufile;
> > > > > >       637			struct ib_ucontext *context;
> > > > > >       638			struct ib_uobject *uobject;
> > > > > >       639			DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
> > > > > >       640		);
> > > > > >       641		struct uverbs_attr attrs[];
> > > > > >       642	};
> > > > > >     > 643	static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
> > > > > >       644		      "struct member likely outside of struct_group_tagged()");
> > > > > >       645	
> > > > > > 
> > > > > 
> > > 
> > > Thanks
> > > --
> > > Gustavo
