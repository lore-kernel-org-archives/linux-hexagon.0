From: Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH v2 01/34] mm: Add PAGE_TYPE_OP folio functions
Date: Thu, 25 May 2023 10:00:23 -0700
Message-ID: <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-2-vishal.moola@gmail.com> <20230525085555.GV4967@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685034035; x=1687626035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHrTsqL0nqeqxBvVw7n3mE3d9UFJpL2j8If6jZFByTc=;
        b=VEXX4D+/ehgygAWm5BmRxKMQVayX+huiD86BmHpUJbQZIavyZk8MqgFgBVJCgltW8G
         DGf1XLm8HhYD7C5Ltu5hncRV4xkFiRLvjnKAKUZAVqhHyZU7uDae6IK3C5qSD3GFgpGy
         OqLSmV63QlFHc9BLqOH+z3/46t/qsNvryv2gOmzRQJTarAzeFF3wkmaawd/u1vYzudf+
         2OoFyE7ArYkSpPwfiPG4wUCBT5egkmxxlXwXAVhzZYomT8xAIzGjfTrChNVAlbK2FaKO
         3t03QrSsNM3MzVGbAgb9jEqdKkZ/GGbY36ZIzPCKupNWpFQuCEQc+t41/FAd5d9jW5uu
         ry0A==
In-Reply-To: <20230525085555.GV4967@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

On Thu, May 25, 2023 at 1:56=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi,
>
> On Mon, May 01, 2023 at 12:27:56PM -0700, Vishal Moola (Oracle) wrote:
> > No folio equivalents for page type operations have been defined, so
> > define them for later folio conversions.
>
> Can you please elaborate why would we need folios for page table descript=
ors?

Thanks for the review!

These macros are for callers that care about the page type, i.e. Table and
Buddy. Aside from accounting for those cases, the page tables don't use fol=
ios.
These are more for the cleanliness of those callers.
