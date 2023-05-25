From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 01/34] mm: Add PAGE_TYPE_OP folio functions
Date: Thu, 25 May 2023 23:20:11 +0300
Message-ID: <20230525202011.GZ4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-2-vishal.moola@gmail.com>
 <20230525085555.GV4967@kernel.org>
 <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685046036;
        bh=TRdhRXxXUIYfs640uIn+I4Rf6UAXCv8idpkcYdsSebM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oiC2XGhNWUAmWE7pr8r3QtJ9JQsEo/jXvve3lXs2r5Y+W4R2mTSVXer6rhbIqd0H3
         uoSQkJ728HLdXkJmf2eWWiJHTRm/fGQOsi2eZMGN8iMwau2U+ioJb0W4RoKYGYtykh
         z9scTeHJfdOUnqeX313qP2xIMkwidI5DxymtOtruiJkZ/HiGGdvi3+NdefCU8HC/4L
         yVF6ukcziPPo5ghUZkvreoJAGRzTQdLIctyd1RS1O+YIm3/yAJVKFl1SAT+U6nvVPE
         TUmcZj1oUZgh7b4Odb9/HzteZyqvh1+JrTl0ADJm08qL98dpyZZ8OeR78PQJMngFPN
         0x/EvMWBkU0Qw==
Content-Disposition: inline
In-Reply-To: <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

On Thu, May 25, 2023 at 10:00:23AM -0700, Vishal Moola wrote:
> On Thu, May 25, 2023 at 1:56=E2=80=AFAM Mike Rapoport <rppt@kernel.org> w=
rote:
> >
> > Hi,
> >
> > On Mon, May 01, 2023 at 12:27:56PM -0700, Vishal Moola (Oracle) wrote:
> > > No folio equivalents for page type operations have been defined, so
> > > define them for later folio conversions.
> >
> > Can you please elaborate why would we need folios for page table descri=
ptors?
>=20
> Thanks for the review!
>=20
> These macros are for callers that care about the page type, i.e. Table and
> Buddy. Aside from accounting for those cases, the page tables don't use f=
olios.
> These are more for the cleanliness of those callers.

But why using folio APIs for PageType will be cleaner than using page APIs?
Do you have an example?

--=20
Sincerely yours,
Mike.
