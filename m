From: Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH -next] hexagon: Fix warning comparing pointer to 0
Date: Thu, 9 Feb 2023 05:07:08 +0000
Message-ID: <SN6PR02MB4205B282F3C5BD2C9B3B07A4B8D99@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230208011105.80219-1-yang.lee@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=c2nGFy+IElPs29N+acJ3sqj/lLfs+KMgOgIaoRRzbrs=;
 b=jYsG49fMoBxeT4wGdWgqJu4eJVu0Y+m50+TtXu2WTAjcVy4FCujsNLlSnOGYTEO74erU
 usNrSr2IfwWKHeBwReGrAA0uZU1PEXAPqxOJ6fI3MgtZOopuSkuz3iaj4Kifpc+ofRlu
 dGzfsw+qwcY1fiyKNS4qdLmd17uGSQHc0klAom1FqLdpCNAvmNXq89jk9kKTJjwz109d
 GZkZ0y2vYx1HFNai+IfwQzqWAHIBnfNyij8vbNkzbEL76HEEs2SwFL71RVv8vLrHK/FW
 kemJbscrsB4ELgbfR58pXMFY6s4+Xv3HbbTtISxnMkKhUare9up3dDa9KRkXDdqXLpn1 RA== 
In-Reply-To: <20230208011105.80219-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Abaci Robot <abaci@linux.alibaba.com>



> -----Original Message-----
> From: Yang Li <yang.lee@linux.alibaba.com>
...
> ./arch/hexagon/kernel/traps.c:138:6-7: WARNING comparing pointer to 0
>=20
> Avoid pointer type value compared with 0 to make code clear.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D3978
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/hexagon/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
> index 6447763ce5a9..fdbbf78b4ce0 100644
> --- a/arch/hexagon/kernel/traps.c
> +++ b/arch/hexagon/kernel/traps.c
> @@ -135,7 +135,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>                 }
>=20
>                 /* Attempt to continue past exception. */
> -               if (0 =3D=3D newfp) {
> +               if (!newfp) {
>                         struct pt_regs *regs =3D (struct pt_regs *) (((vo=
id *)fp)
>                                                 + 8);
>=20
> --
> 2.20.1.7.g153144c

Acked-by: Brian Cain <bcain@quicinc.com>


