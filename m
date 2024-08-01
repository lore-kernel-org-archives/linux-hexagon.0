Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598C14B097;
	Thu,  1 Aug 2024 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722550470; cv=none; b=APOXoTrSkO32rquRuRHnts1ICWbOS7iOTZ9n7fXtJ/Gyx/ODxswfLbfHJixMF0Mc8V04DYzcwosMXrawwpdPHOt+5cAoUpOwsAaizBTNu1l8ZGgddZNtmiUPxA75dRpShGs5mLsrdk1iDEfeZQBbSSHN4Oged5ZRE7fV+auhz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722550470; c=relaxed/simple;
	bh=CeR3LVp7OW0w7GTxNWNq2oLZvH6C4PKoEL3irC/Eq+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnydi05IE7cpnDK5cqlOnlxqrmGec0SYXDsgigyP28MG9rM9nzmLkLiueHHHLJL0nRkGTv6sj2AKWQVZr32++/VMALXTyGwjyBVx7WWqL5tl06qUplEUy/oBOpyJBodtLqi3uoykaWKSOWYpCHNJm2BKfvOHdpGTEVQpEfYrs2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOxaEvCf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOxaEvCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F8C32786;
	Thu,  1 Aug 2024 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722550470;
	bh=CeR3LVp7OW0w7GTxNWNq2oLZvH6C4PKoEL3irC/Eq+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOxaEvCfLBUq2g9e5M/sEp9MLVwZGW4FFDb/IudJEWOggIs5c7Q9suLcMrpWZq9HM
	 gTycS/5aBkGnIrwi3NrvhmWT9D6sD1Lx+NhuX/XQ+6OddW06eJ/9u5RPodw3nnvnNF
	 zrLWY8aTLqq8YEo4Y9jS1g+bxKDGhNGoz9gDUmR3DtTOsfup1HupE9lDdVYH3LQ3Uo
	 TxXLks/lbabFdDt6ddk/s8Hn3rWzIOpZy22ynVx0uTKvnvqAL0ruDLFcpJjwd37UqY
	 62eLmaLCN+Jf10gmZQw9DgLfWtT8dBT8+UakKmq7WIWijPKISYad3L2MQ9Xa6y2Zr6
	 e24jsPf0nHmww==
Date: Thu, 1 Aug 2024 15:14:27 -0700
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
Message-ID: <20240801221427.GA3773553@thelio-3990X>
References: <202408011956.wscyBwq6-lkp@intel.com>
 <138da3e5-0e24-41a6-bb35-df5d07045eb3@embeddedor.com>
 <20240801190813.GC122261@thelio-3990X>
 <f40160aa-7cbd-4264-be44-45396b09574f@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40160aa-7cbd-4264-be44-45396b09574f@embeddedor.com>

On Thu, Aug 01, 2024 at 02:17:50PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 01/08/24 13:08, Nathan Chancellor wrote:
> > On Thu, Aug 01, 2024 at 06:47:58AM -0600, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 01/08/24 05:35, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc-2
> > > > head:   df15c862c1b93b6e1f6c90b0d7971f7a6ad66751
> > > > commit: e7cd9f429a852fb7e37a706c7d08fc36e7863e06 [11/18] RDMA/uverbs: Use static_assert() to check struct sizes
> > > > config: hexagon-randconfig-001-20240801 (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/config)
> > > > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 430b90f04533b099d788db2668176038be38c53b)
> > > 
> > > 
> > > Clang 20.0.0?? (thinkingface)
> > 
> > Indeed, Clang 19 branched and main is now 20 :)
> > 
> > https://github.com/llvm/llvm-project/commit/8f701b5df0adb3a2960d78ca2ad9cf53f39ba2fe
> 
> Yeah, but is that a stable release?

No, but the Intel folks have tested tip of tree LLVM against the kernel
for us for a few years now to try and catch issues such as this.

> BTW, I don't see GCC reporting the same problem below:

Hexagon does not have a GCC backend anymore so it is not going to be
possible to do an exact A/B comparison with this configuration but...

> > > > > > include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()
> > > >        643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
> > > >            | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >        644 |               "struct member likely outside of struct_group_tagged()");
> > > >            |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >      include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
> > > >         16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
> > > >            |                                 ^
> > > >      include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
> > > >         77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> > > >            |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >      include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
> > > >         78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> > > >            |                                                        ^~~~
> > > >      include/rdma/uverbs_ioctl.h:643:58: note: expression evaluates to '56 == 52'

This seems to give some indication that perhaps there may be some
architecture specific here with padding maybe? I seem to recall ARM OABI
having something similar. Adding the Hexagon folks/list to get some more
clarification. Full warning and context:

https://lore.kernel.org/202408011956.wscyBwq6-lkp@intel.com/

The problematic section preprocessed since sometimes the macros
obfuscate things:

struct uverbs_attr_bundle {
        union {
                struct {
                        struct ib_udata driver_udata;
                        struct ib_udata ucore;
                        struct ib_uverbs_file *ufile;
                        struct ib_ucontext *context;
                        struct ib_uobject *uobject;
                        unsigned long attr_present[(((UVERBS_API_ATTR_BKEY_LEN) +
                                                     ((sizeof(long) * 8)) - 1) /
                                                    ((sizeof(long) * 8)))];
                };
                struct uverbs_attr_bundle_hdr {
                        struct ib_udata driver_udata;
                        struct ib_udata ucore;
                        struct ib_uverbs_file *ufile;
                        struct ib_ucontext *context;
                        struct ib_uobject *uobject;
                        unsigned long attr_present[(((UVERBS_API_ATTR_BKEY_LEN) +
                                                     ((sizeof(long) * 8)) - 1) /
                                                    ((sizeof(long) * 8)))];
                } hdr;
        };

        struct uverbs_attr attrs[];
};
_Static_assert(__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
                       sizeof(struct uverbs_attr_bundle_hdr),
               "struct member likely outside of struct_group_tagged()");

FWIW, I see this with all versions of Clang that the kernel supports
with this configuration.

Cheers,
Nathan

> > > >        643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
> > > >            | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >        644 |               "struct member likely outside of struct_group_tagged()");
> > > >            |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >      include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
> > > >         77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> > > >            |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >      include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
> > > >         78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> > > >            |                                                        ^~~~
> > > >      7 warnings and 1 error generated.
> > > > 
> > > > 
> > > > vim +643 include/rdma/uverbs_ioctl.h
> > > > 
> > > >      630	
> > > >      631	struct uverbs_attr_bundle {
> > > >      632		/* New members MUST be added within the struct_group() macro below. */
> > > >      633		struct_group_tagged(uverbs_attr_bundle_hdr, hdr,
> > > >      634			struct ib_udata driver_udata;
> > > >      635			struct ib_udata ucore;
> > > >      636			struct ib_uverbs_file *ufile;
> > > >      637			struct ib_ucontext *context;
> > > >      638			struct ib_uobject *uobject;
> > > >      639			DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
> > > >      640		);
> > > >      641		struct uverbs_attr attrs[];
> > > >      642	};
> > > >    > 643	static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
> > > >      644		      "struct member likely outside of struct_group_tagged()");
> > > >      645	
> > > > 
> > > 
> 
> Thanks
> --
> Gustavo
