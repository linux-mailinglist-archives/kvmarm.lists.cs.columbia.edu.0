Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B55DC1A4317
	for <lists+kvmarm@lfdr.de>; Fri, 10 Apr 2020 09:43:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D94224B1C2;
	Fri, 10 Apr 2020 03:43:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8VpUIcXMd-Cp; Fri, 10 Apr 2020 03:43:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C63AF4B13A;
	Fri, 10 Apr 2020 03:43:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 390A74B0F6
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Apr 2020 17:30:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c2dMQuI5oGeo for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Apr 2020 17:30:00 -0400 (EDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 593714B0B3
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Apr 2020 17:30:00 -0400 (EDT)
Received: by mail-pg1-f180.google.com with SMTP id s4so70963pgk.10
 for <kvmarm@lists.cs.columbia.edu>; Thu, 09 Apr 2020 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=2haAfgLKYBB+Ck2GeXIDF02e3G20o5okdEJ4GVkyKHY=;
 b=tlTPjD5qX1MtNLUbFTxtsi76wOwwBHkm6mxp4SXIuDhluz+iSqnUtFTOx6AzLoXsQo
 Zgj+ehZUI2jX9tH8O/JCxL2ihIsf4moF15t6fRw8P5Ym4pTdc146gWvpNO9nY16SQWn8
 7yUSA52DM1+fEKL3SgUdcz2KZnx4ioc+THh/3lJw63BpVDqacYiIN0wrelbj4voix8vu
 j/+BvvW3H9y8/oX1rGFK6y56BGFUK4D/f6CpeFukUj6m1UxRcPJoksN6cnSHSegwqmhU
 bcYeBg1xzLfO3LlGy2INslidV9R96grhRuj1Mfqmmpd5ML2y6Yekp6pRFR00T/4jQMu/
 8dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=2haAfgLKYBB+Ck2GeXIDF02e3G20o5okdEJ4GVkyKHY=;
 b=si8tCRGIwyVi6sO8VHKAiRhZwxtV9mj8RcP1Ky931X6NzKi04phbB1LaZqzm5mEcjg
 sJHj/9s/zNCDbNCjkRiWdlYcEd5KCHhZXFsjuUn5OdElHEkr2hqrbgd8nrnH3b6sUzm/
 ApccsCv1V9RK+WqiJgCQcnbEQRtrkjwR36+kUsdTPuyRT2rH1GDaopR04aK3Aq/MvxGy
 nfm8Cyqra5KejBShS8/3IVKO6XJK123jGUhOObUi7dtQUcqtfRUvcOSsOOjhiiw8ePhi
 ThDRqgEuPbEvrpOCkK/LjKUHze7uq6WCMzcjbJwNNzA4fieKmwDseWzS8HOsQKwGBKQW
 YO1Q==
X-Gm-Message-State: AGi0Pub+2jTGjcdzTo02pAf0nFbL76KGqkgT4HA7MAiZTgZZRqWSxwCx
 DERekIf8ZYbuQxdhB9m3I8hP4AOkdFNAkaJjwcg=
X-Google-Smtp-Source: APiQypJnWgQFTPi8xfW1m4+qOKK0mlo6V+P1r1kcFFpIZEOaf7lUiz0lOQSrJbDk84F/UXmMTZCTwebVzQC9m/zitJE=
X-Received: by 2002:a63:ae04:: with SMTP id q4mr1333418pgf.373.1586467799380; 
 Thu, 09 Apr 2020 14:29:59 -0700 (PDT)
MIME-Version: 1.0
From: Javier Romero <xavinux@gmail.com>
Date: Thu, 9 Apr 2020 18:29:47 -0300
Message-ID: <CAEX+82KTJecx_aSHAPN9ZkS_YDiDfyEM9b6ji4wabmSZ6O516Q@mail.gmail.com>
Subject: Contribution to KVM.
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-Mailman-Approved-At: Fri, 10 Apr 2020 03:43:52 -0400
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hello,

 My name is Javier, live in Argentina and work as a cloud engineer.

Have been working with Linux servers for the ast 10 years in an
Internet Service Provider and I'm interested in contributing to KVM
maybe with testing as a start point.

If it can be useful to test KVM on ARM, I have a Raspberry PI 3 at disposal.

Thanks for your kind attention.

Best Regards,



Javier Romero
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
