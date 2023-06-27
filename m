From: Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Tue, 27 Jun 2023 10:42:07 -0700
Message-ID: <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com> <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687887739; x=1690479739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i618d6TBDc9eRPjFDJkpeqKfOfbO3uM7uCEV9XLltFk=;
        b=HvOjTHjCD8itMm1xp5AnK/TmYH5tQiF1El2gyMO5zpqTY4wM1G2ir3ku6089UY1inQ
         ilXwuLjIDRYIMPHiQPHPbFQRy/hIa9oVwH0QYqAm53mZsyIpL6HgYzNNL/NNLIh2SC53
         /Joi55NqQPacIQIaSPLnjCH7o6qvV31ICWbCQ8IiY+RsTUhqfYiVoVRzcNBSzvMpURs/
         f/RKmZePqghHrHdV5n1so0lsBS2EaZX77ICe7eDI+jllhbMiPBHJhxnD9h+Hh+PnGjAo
         7epexu03a+N5aJGPnt128CQw+E8IVZS3OeUo6R0hlPLkskRaMfOu6WUJJOIpsapTfYI9
         tHRw==
In-Reply-To: <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Dinh Nguyen <dinguyen@kernel.org>, Mike Rapoport <rppt@kernel.org>

On Mon, Jun 26, 2023 at 10:47=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
> > Part of the conversions to replace pgtable constructor/destructors with
> > ptdesc equivalents.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>
> This patch causes all nios2 builds to fail.

It looks like you tried to apply this patch on its own. This patch depends
on patches 01-12 of this patchset to compile properly. I've cross-compiled
this architecture and it worked, but let me know if something fails
when its applied on top of those patches (or the rest of the patchset).
