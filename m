From: Brian Cain <bcain@quicinc.com>
Subject: [GIT PULL] hexagon changes for v5.18
Date: Mon, 28 Mar 2022 21:08:23 +0000
Message-ID: <SN6PR02MB42053E6FCED122482A5893D0B81D9@SN6PR02MB4205.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1648501711; x=1649106511;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vTpezr4NeclYWRYBUmdsIMPgmqZLiBf5F3g3D11Mzis=;
  b=nc12b6QwKBogPVZWhwkPoj0kCzIuHBQ8m5ajhiBdT0QXRcSnPpWZ3vG8
   7eRFvpwIJmiGsVRbjf8Gfhq93JS+QIHPvFgkk7a9A9xeZhu61RzM7XHXA
   HQDoUHCuMw7Pdfn+9dEFUqypdcIdks1g+L6qCW+UL5bqZXHZnj4diNy0l
   Q=;
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Linus,

Please pull the following change for Hexagon: it contains a maintainer emai=
l address update.

Thanks,
-Brian

=3D=3D=3D

The following changes since commit 7203062171db6669f746d14148c4af76af619e74=
:

  Merge tag 'tty-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git=
/gregkh/tty (2022-03-28 13:00:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux tags/hexagon-5.=
18-0

for you to fetch changes up to b0cf9b4b26e697886bf0986579953c16cf92d3d2:

  MAINTAINERS: update hexagon maintainer email, tree (2022-03-28 13:51:54 -=
0700)

----------------------------------------------------------------
Maintainer email update

----------------------------------------------------------------
Brian Cain (1):
      MAINTAINERS: update hexagon maintainer email, tree

MAINTAINERS | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)
