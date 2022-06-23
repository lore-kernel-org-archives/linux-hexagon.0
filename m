From: Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH] hexagon: drop unexpected word 'a' in comments
Date: Thu, 23 Jun 2022 06:53:31 +0000
Message-ID: <SN6PR02MB4205512B03E6C2367BCFB5AEB8B59@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20220623065100.8268-1-jiangjian@cdjrlc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1655967215; x=1656572015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ythyCRJjMu1c1gVpaSsk+/RrL73NfzS1d5MoENdvEzs=;
  b=nH8C/JTpgsc2rWg09xNSh+4/7a/1RWuDQFH6PVYFZPRGtVVYoWANMCzd
   MZF0SKTEOZeomIHAlm/8dmMuLARh7tdaCLqNESFsxS3n2uFJN1DOvDDos
   p3t2BTnk/FY6QIg9ySEW38mrFNRA5qEaOmuDUj/MClHnmL8RKrosoOF2n
   g=;
In-Reply-To: <20220623065100.8268-1-jiangjian@cdjrlc.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: Jiang Jian <jiangjian@cdjrlc.com>
Cc: "ebiederm@xmission.com" <ebiederm@xmission.com>, "nathan@kernel.org" <nathan@kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "keescook@chromium.org" <keescook@chromium.org>, "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> -----Original Message-----
> From: Jiang Jian <jiangjian@cdjrlc.com>
...
>=20
> there is an unexpected word 'a' in the comments that need to be dropped
>=20
> file - arch/hexagon/kernel/traps.c
> line - 262
>=20
> * Precise bus errors may be recoverable with a a retry,
>=20
> changed to:
>=20
> * Precise bus errors may be recoverable with a retry,
>=20
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  arch/hexagon/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
> index 6447763ce5a9..a1f1085887aa 100644
> --- a/arch/hexagon/kernel/traps.c
> +++ b/arch/hexagon/kernel/traps.c
> @@ -259,7 +259,7 @@ static void illegal_instruction(struct pt_regs *regs)
>  }
>=20
>  /*
> - * Precise bus errors may be recoverable with a a retry,
> + * Precise bus errors may be recoverable with a retry,
>   * but for now, treat them as irrecoverable.
>   */
>  static void precise_bus_error(struct pt_regs *regs)
> --
> 2.17.1

Acked-by: Brian Cain <bcain@quicinc.com>
