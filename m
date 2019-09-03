From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 04/26] mips: remove ioremap_cachable
Date: Tue, 3 Sep 2019 08:57:00 +0000
Message-ID: <MWHPR2201MB1277E4E8214F6E50E5EC9BFCC1B90@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190817073253.27819-5-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKGjwp1Uo8LfIHoyH7+b//d/bD44+fJfePgvviW7l8g=;
 b=VCoxzS8WWTGfTcQYd0/WZ+jzrF0fosMbreNkfKpbvjQ4IW659Bg+NPwvuAf4EQKOuVRKFsAOj0pCb8p+7Dill9cY5mxZ4QAPW5CJCiLvD1LY+jZ1udVFo87TRkJbmYam+XgewallJsGzm3jjrChp1wMbXFymbbSiyHLv9/Ei034=
In-Reply-To: <20190817073253.27819-5-hch@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>

Hello,

Christoph Hellwig wrote:
> Just define ioremap_cache directly.

Applied to mips-next.

> commit 60af0d94cc37
> https://git.kernel.org/mips/c/60af0d94cc37
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
