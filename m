From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] mm: Move mem_init_print_info() into mm_init()
Date: Thu, 18 Mar 2021 00:40:18 +0000
Message-ID: <ea5a9027-b0a6-e06d-b3ac-00b8ac43883e@synopsys.com>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616028035; bh=0XKVKKfj7vScxcVfHEcdOU8GWAMjI76oTy2DnVvY6f8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Q6kKcnGarbhl3M9HnBbytVHFm0tgZRZWGqKPlXpeoi+KSXnbEQJNV0Tddb/q6+YW3
         xMoKYf2wUpcGriHhWAuBHz6hzLs+0rY27xu4lZ8ZEV5A2IEvBSBajF20Zq1RRCD2xX
         qIz5m+PlzLjjurLMLm1AL9lseWQH+01wLKrY75dLr6STI/i4D6+TvKt96lw7b6m8KA
         jr4JHiTTMqqz3T66w7dna2FeAj3AaB5TlbkpqpfitHqbxtY3bVfRpLLy+rKc3c95qv
         MLxT1BVjBEa6MAPN5HsHXbz2FqnJQ0YzX9lrlwXdRE5GPupyMo6m3E4+V3kYV1M5p0
         VwW3PkiSFTcig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XKVKKfj7vScxcVfHEcdOU8GWAMjI76oTy2DnVvY6f8=;
 b=dYqGjhfydLT3jKobs90Pu7fsawiFIyhLKVJRfku+6Xd5D90hE17bwQhkNt5g2BSGdthS/3yAUsYpqxzLTR/BsWDlnWXS7g+D7ahVqoiJj6HWsxzhi9hWD+7elJHCwnYiS72h7VH122pvAva3gnAoz6ZziJivuWQg+XGvSYzINUg=
In-Reply-To: <20210317015210.33641-1-wangkefeng.wang@huawei.com>
Content-Language: en-US
Content-ID: <77FDBA25A9ECC14B8AFA2C93CFCEF4E9@namprd12.prod.outlook.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kefeng Wang <wangkefeng.wang@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Richard Henderson <rth@twiddle.net>, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Huacai Chen <chenhuacai@kernel.org>, Jonas Bonn <jonas@southpole.se>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-csky@vger.kernel.org" <linux-csky@vger>

T24gMy8xNi8yMSA2OjUyIFBNLCBLZWZlbmcgV2FuZyB3cm90ZToNCj4gbWVtX2luaXRfcHJpbnRf
aW5mbygpIGlzIGNhbGxlZCBpbiBtZW1faW5pdCgpIG9uIGVhY2ggYXJjaGl0ZWN0dXJlLA0KPiBh
bmQgcGFzcyBOVUxMIGFyZ3VtZW50LCBzbyB1c2luZyB2b2lkIGFyZ3VtZW50IGFuZCBtb3ZlIGl0
IGludG8gbW1faW5pdCgpLg0KPiANCj4gQWNrZWQtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNl
bkBsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtlZmVuZyBXYW5nIDx3YW5na2Vm
ZW5nLndhbmdAaHVhd2VpLmNvbT4NCg0KQWNrZWQtYnk6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5
bm9wc3lzLmNvbT4NCg0KVGh4LA0KLVZpbmVldA0K
