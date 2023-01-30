From: Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH] trap: Fix warning comparing pointer to 0
Date: Mon, 30 Jan 2023 16:43:15 +0000
Message-ID: <SN6PR02MB4205F8504967B809BA7EEFBFB8D39@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230128093920.2729-1-jiapeng.chong@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=OL0jQeLXNviyA+tR6w9sJgml8ooOC6G1slO1eMzLUOA=;
 b=fQEtQHdkTL39wuHQBfZ0JCINBGUmAgnRJjXvp8n7+/N3y0znNRjomlqwspSXkf7Kqdxd
 PGn5YRYFthqgtJVi46EgHh6Fecd3Jw7gzaoia3TELLHfILS4vSESuEvIDWt24lpoBiHz
 ESvOOeWxr6ETjM8en9kmEKDFaswJ18l+OwEaFEcXlHDKWmzs2uM4fZfvxClaMgMLums/
 2auxFg/Sc4Rw3VnhuMHt9hMtrRL6YbsAoaUYehI+u6/17UwYkC7SSKm2t4DTQC6ZrO1B
 Hojg8UQdXfcNbolYz9ja9A7DQzpuZuIFywdJxlSZ/eEL5Uipnwgrq++NWcUHv/q6K37k Fw== 
In-Reply-To: <20230128093920.2729-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Abaci Robot <abaci@linux.alibaba.com>

> -----Original Message-----
> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
...
>=20
> Avoid pointer type value compared with 0 to make code clear.
>=20
> ./arch/hexagon/kernel/traps.c:138:6-7: WARNING comparing pointer to 0.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D3860
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
