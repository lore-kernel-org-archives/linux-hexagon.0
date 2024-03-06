Received: from mail.venturelabo.com (mail.venturelabo.com [217.61.16.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A75DF14
	for <linux-hexagon@vger.kernel.org>; Wed,  6 Mar 2024 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.61.16.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715787; cv=none; b=KxmTjxKZfg5rakyMIiqw/P3cEtFSM5eDSoZbM2cfofwKinOcMpCY96wj9l0lX+PE2QH43ehyfoSr820zAiU9NMDoQ2Hrc1dawFSXs/CPVMXxBnZZePFdjFn9HDnNbHuhC2r9JVKUieNjCSsx0k3wOJr1bo4yk1FJ/M6BWEEOoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715787; c=relaxed/simple;
	bh=oVYciwbxp9yZz27tJe420FcSGVopAaIKXnmPDsbSoXg=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=hew+BLdP5E/jSnJbiMp93Lfhz+IX/lCwbX35hMk2wofbekdZ/jwOlw3vd6WnDGwdiAKHHF/HjrWghLkdcYxjJ/jPbY1QXiZ0pkN1X6oFmPE1dDGSa3ci14Xb6uvg2Qnj0mxU1kIY2PzBfcZzY5l5OIH6U4CB10Sqjr3ag29xPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=venturelabo.com; spf=pass smtp.mailfrom=venturelabo.com; dkim=pass (2048-bit key) header.d=venturelabo.com header.i=@venturelabo.com header.b=rt71+eQl; arc=none smtp.client-ip=217.61.16.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=venturelabo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venturelabo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=venturelabo.com header.i=@venturelabo.com header.b="rt71+eQl"
Received: by mail.venturelabo.com (Postfix, from userid 1002)
	id A9588827CD; Wed,  6 Mar 2024 09:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturelabo.com;
	s=mail; t=1709715329;
	bh=oVYciwbxp9yZz27tJe420FcSGVopAaIKXnmPDsbSoXg=;
	h=Date:From:To:Subject:From;
	b=rt71+eQl5wBbX4+TXa2GuwPhFalOkbO/tT6rfujV0uJNHxVOGlUr8dXPKrCW01uCr
	 oS35RZzGSkMMHwDeb3eq57c7euR4/yzhjzFPo8lgXrA4oj2vd7BcFqUhgQgQHpGz9b
	 V2Np9aqxcm8dQmrnH+Zlh9vW9e4goyTxV5qX34Ei+0hfEUcmeVV8FFj0F2cSt6ou6Z
	 KNv0WhSohpXG8hdIv9KwV8vQtKN/2h30qjGfZ5nFuAnqx/niuI37l1LIz/ncvClSYG
	 u6rnS489ArKZWEidcuY6EYNF+OAwjx8W9eUAL2G0BCQhOLpt8+I6L7umk0bhSlE5T1
	 ELcV03rz42/Dw==
Received: by mail.venturelabo.com for <linux-hexagon@vger.kernel.org>; Wed,  6 Mar 2024 08:55:18 GMT
Message-ID: <20240306084500-0.1.z.1ubp.0.3mfoqmzhfh@venturelabo.com>
Date: Wed,  6 Mar 2024 08:55:18 GMT
From: "Hugh Felton" <hugh.felton@venturelabo.com>
To: <linux-hexagon@vger.kernel.org>
Subject: Tailored educational solutions.
X-Mailer: mail.venturelabo.com
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We support curriculum creators, scientific equipment providers, and textb=
ook publishers in delivering innovative and effective educational tools.

With over 92 years of experience in creating educational products for stu=
dents and teachers, our presence in international markets allows us to sh=
are our expertise from the perspective of various needs and challenges.

Our solutions enrich the teaching process of STEM subjects, increase stud=
ent engagement, and improve learning outcomes.

We offer a wide range of products, starting from laboratory equipment (bi=
ology, chemistry, physics) for all educational levels, to biological spec=
imens (live and preserved organisms), anatomical models, laboratory chemi=
cals, scientific equipment, and ready-made sets for working with students=
 in lessons.

Our curriculum programs tailored for elementary schools, middle schools, =
and higher education institutions provide support on multiple fronts, all=
owing for utilization in various educational environments, including remo=
te learning.

Could I present how our products can contribute to the development of you=
r company?


Best regards
Hugh Felton
