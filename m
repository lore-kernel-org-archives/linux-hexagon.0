From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
Date: Sat, 31 Jul 2021 23:12:38 +0000
Message-ID: <1036d104-44c1-b162-2262-973226628be2@synopsys.com>
References: <20210731052233.4703-1-masahiroy@kernel.org>
 <20210731052233.4703-2-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1627773196; bh=/S86EVYPGY9xO3kUoJy56OQzYShJeYu8vWMcA/vI1hU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cSknRoUDYnV5K4e9RsktZTB3QGt2oCEb40SBNrfyh9F+EmNso1AAl6mimKoLm4Z9q
         khyQvwqSZMh/b/Bx1hwv6KmrDnrBMAkYlKcvTB6+yI+xCL5FSzLYTByDQnJ2OvadN+
         3F9QsvB9tzuxlD09nUjofDPzIEIr0tmc8Cu9mI0vuYnj2NMrIug8z2eYy+4czpfEXj
         Z3LmxLa5LXEHOkJWlry4xLGnfMHtmXYTKDJbbWD4mMGtv/4vHxsZdh+8/LFn9vS/5M
         Z+6h3mB1Pq6c8L7GYiHzosHPQZDDYwhJii5aBORBdt6MwcDUNT/C6CovEDYJobnFjO
         ynYFu45BOhzmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S86EVYPGY9xO3kUoJy56OQzYShJeYu8vWMcA/vI1hU=;
 b=YG5vmKaaTr8H8brX5rjKTHUnmj2TIgOVM/BnGwDsLv37PoaFI78mHpo97eW7w0cnAEtfgxQVbwI7la7nLB6605apE4qQrON0rxo+18q6Cy+kEKHeMHuCvyMsiZRoS3jt2urRBeFdIA08oyOzGgFlT5HL4upq6yltkbqR3lpRE4U=
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
Content-Language: en-US
Content-ID: <D343C53D18DD6D43ADCBB013B53C2A98@namprd12.prod.outlook.com>
List-ID: <linux-hexagon.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>, Ley Foon Tan <ley.foon.tan@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Nick Hu <nickhu@andestech.com>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, YiFei Zhu <yifeifz2@illinois.edu>, Greentime Hu <green.hu@gmail.com>, Palmer

T24gNy8zMC8yMSAxMDoyMiBQTSwgTWFzYWhpcm8gWWFtYWRhIHdyb3RlOg0KPiBNYWtlIGFyY2hp
dGVjdHVyZXMgc2VsZWN0IFRSQUNFX0lSUUZMQUdTX1NVUFBPUlQgaW5zdGVhZCBvZg0KPiBoYXZp
bmcgbWFueSBkZWZpbmVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXNhaGlybyBZYW1hZGEgPG1h
c2FoaXJveUBrZXJuZWwub3JnPg0KPiAtLS0NCj4NCj4gICBhcmNoL2FyYy9LY29uZmlnICAgICAg
ICAgICAgICB8IDQgKy0tLQ0KPiBbc25pcC4uXQ0KDQoNCkFja2VkLWJ5OiBWaW5lZXQgR3VwdGEg
PHZndXB0YUBzeW5vcHN5cy5jb20+wqDCoCAjYXJjaC9hcmMNCg0K
