From: Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH] kernel: exit: cleanup release_thread()
Date: Sat, 20 Aug 2022 17:42:15 +0000
Message-ID: <BN7PR02MB4194B2148C8F9183AD6504B3B86F9@BN7PR02MB4194.namprd02.prod.outlook.com>
References: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=l8KECb0a5P+N6A2RzAwTF9GB+WOdmqpC3DwXKrkL2YA=;
 b=O7CoJ0VNu1C3eXtWEuNvCh52VBzIBrHipn8sB/NADs4pG4PAirxtCPj3oefR0me6hck6
 7H64WxYsRSBNxwomecxwtYiVnC9YWJnAJ5sZf1RR/taYOpqwgQmYKY0QmOID2HcZI1+P
 0iSvRgpz6BhIE4khWfhdLJ3lajA4o9lLgKdsQ4fjDAxQAb5oQUJ28kPB/l+uvgcDC49H
 LFI+lx6yw5jfs6yyOmFzJZ6bvtYaMIvwF1LuHkS8hCQ1J9HbGNAAQMfXr+B3G/g8qETv
 fKz7oW0XyCGR27zHlFTpcybXaZAzSOp0J1VmnYTXoEgpK0O6cZCE7tBjYIo4H0+BdNns 7w== 
In-Reply-To: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership>



> -----Original Message-----
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
...
> Only x86 has own release_thread(), introduce a new weak
> release_thread() function to clean empty definitions in
> other ARCHs.
>=20
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Acked-by: Brian Cain <bcain@quicinc.com>
