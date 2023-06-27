From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Tue, 27 Jun 2023 12:10:20 -0700
Message-ID: <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687893024; x=1690485024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yS/xmFpqe6+k8T+yWQv7frf8UxF7B6Cm+1CNfhqUPlA=;
        b=BMqSkVfZP75OxNlOqvaghKGJv9m0y4sm8KFw5SHceiXFQz/e0SiiKJT9I5B52iAH17
         cMt4KC2GjU9iq0SnaoF95JUsMa0mk+JEcq2FkRIOzoow88IvYkDfH7aBL3K5PbCOKOue
         txhLzT7BLkzfYn4DxxqSwsZ2KmDA6ILNOIWpC3UOJTW+EHWbeQQdlcmGoaBUyJofM5AY
         lnVmBNLdubBt20V6jFfi37xAvQhhTT8MryCyACblmLywm5IjXVYJCWSIUi3pbGc+j98S
         r4FtzORgbma5+HwlZ2RT9hRW9y3a8jxCdKlGNGBWvRri5+DzenA7COAJXTL5/EtGEK0g
         cong==
Sender: Guenter Roeck <groeck7@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Dinh Nguyen <dinguyen@kernel.org>, Mike Rapoport <rppt@kernel.org>

On 6/27/23 10:42, Vishal Moola wrote:
> On Mon, Jun 26, 2023 at 10:47=E2=80=AFPM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
>>
>> On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
>>> Part of the conversions to replace pgtable constructor/destructors with
>>> ptdesc equivalents.
>>>
>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>>
>> This patch causes all nios2 builds to fail.
>=20
> It looks like you tried to apply this patch on its own. This patch depends
> on patches 01-12 of this patchset to compile properly. I've cross-compiled
> this architecture and it worked, but let me know if something fails
> when its applied on top of those patches (or the rest of the patchset).


No, I did not try to apply this patch on its own. I tried to build yesterda=
y's
pending-fixes branch of linux-next.

Guenter

