From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v3 03/34] s390: Use pt_frag_refcount for pagetables
Date: Thu, 1 Jun 2023 15:19:00 +0200
Message-ID: <20230601151900.6f184e8c@thinkpad-T15>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
        <20230531213032.25338-4-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tTBWxMHAGeJlpPAzqjw4yCDaupaYk6+WOuZ0r7RHXlQ=;
 b=S/K5bR2wzWD8jF0s2LtK3vF/J1ec5Pw9lqbPdCL6ZXZARzxk77m6XthOAVrzcENBYS/e
 ov9SEtmnnKsZTXa99Jk5hlMimhCPtmwo+YCJttdvMRkZI8Kj3tec3MJCAkANML7vJgEN
 mm82HHoVVpteTT1109f2h3OEi5Dtya1+qWK/izBLKcrhp4adRtqmgRrMH7o6BtITpGsV
 XQajjlwcskrHiNYJ0m2IzKlfajqLyEOsVlAvnpMojNTW61NI6Y/l6FXM9CcrwKrRoiRU
 5yYyiViugHG/GJk6Dj84G7GFPGbzxZudOaESQkF8/B03VEx03rqx3lIPkJn/GXcV7VmA dQ== 
In-Reply-To: <20230531213032.25338-4-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Hugh

 On Wed, 31 May 2023 14:30:01 -0700
"Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> s390 currently uses _refcount to identify fragmented page tables.
> The page table struct already has a member pt_frag_refcount used by
> powerpc, so have s390 use that instead of the _refcount field as well.
> This improves the safety for _refcount and the page table tracking.
> 
> This also allows us to simplify the tracking since we can once again use
> the lower byte of pt_frag_refcount instead of the upper byte of _refcount.

This would conflict with s390 impact of pte_free_defer() work from Hugh Dickins
https://lore.kernel.org/lkml/35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com/
https://lore.kernel.org/lkml/6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com/

There he uses pt_frag_refcount, or rather pt_mm in the same union, to save
the mm_struct for deferred pte_free().

I still need to look closer into both of your patch series, but so far it
seems that you have no hard functional requirement to switch from _refcount
to pt_frag_refcount here, for s390.

If this is correct, and you do not e.g. need this to make some other use
of _refcount, I would suggest to drop this patch.
