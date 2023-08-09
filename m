From: Brian Cain <bcain@quicinc.com>
Subject: RE: hexagon: fix warning comparing pointer to 0
Date: Wed, 9 Aug 2023 19:04:33 +0000
Message-ID: <SN6PR02MB420564C1F86A0BB6E76E24DEB812A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230809185147.98262-1-rauji.raut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=veOTtxOYvvtEWgQLPaVIUz8sBAiab8SQ5VEgKWgiXXA=;
 b=ipTLirKGJsLafbMSqBwZWYQMaoKExndPkruXJbJwEpryx1u5MGCBBAQunt0AQBL1UkDe
 h3AwaB4TT3+4N/jJpUA4Cf1XKO1S3MKAu20l4XXqM86rD56AOFbIavUBQOzDknFlskuS
 fjXjP9bBvMyduGiIiI7WyIciQeWvJ+/ravabeU9n2O7AfSzJmjPQR9JveYNZ6KdCUaWL
 5roOv8xRT3wLmLq0fp+51NXrNCyuIoEXBPiGtLK4cR8Ui2Pw9PvU/8VDJpyjfSwTFmlw
 hQJpB2ZpSFB3k6ajGqDv3uDgbJFYRHFzJ/S3jMF+1/D4GY0YfCjbf1lsTPUKtCPaMb2y 1Q== 
In-Reply-To: <20230809185147.98262-1-rauji.raut@gmail.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: Atul Raut <rauji.raut@gmail.com>
Cc: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>



> -----Original Message-----
> From: Atul Raut <rauji.raut@gmail.com>
> Sent: Wednesday, August 9, 2023 1:52 PM
> To: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org; linux-kernel-
> mentees@lists.linuxfoundation.org
> Subject: hexagon: fix warning comparing pointer to 0
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> Fix the following coccicheck warning:
> ./arch/hexagon/kernel/traps.c:138:6-7: WARNING comparing pointer to 0
>=20
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> ---
>  arch/hexagon/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
> index 6447763ce5a9..78486eea77d7 100644
> --- a/arch/hexagon/kernel/traps.c
> +++ b/arch/hexagon/kernel/traps.c
> @@ -80,7 +80,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>         int kstack_depth_to_print =3D 24;
>         unsigned long offset, size;
>         const char *name =3D NULL;
> -       unsigned long *newfp;
> +       unsigned long *newfp =3D NULL;
>         unsigned long low, high;
>         char tmpstr[128];
>         char *modname;
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
> 2.34.1

Acked-by: Brian Cain <bcain@quicinc.com>=20
