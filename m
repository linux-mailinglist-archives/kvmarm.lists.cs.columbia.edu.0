Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5C91C36831E
	for <lists+kvmarm@lfdr.de>; Thu, 22 Apr 2021 17:13:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C8AE44B500;
	Thu, 22 Apr 2021 11:13:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@nvidia.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NfhUBI7vRp+e; Thu, 22 Apr 2021 11:13:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 077844B4F7;
	Thu, 22 Apr 2021 11:13:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 200534B0C8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 11:04:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oTLQ7xtoudaL for <kvmarm@lists.cs.columbia.edu>;
 Thu, 22 Apr 2021 11:04:50 -0400 (EDT)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690073.outbound.protection.outlook.com [40.107.69.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F3A9F4B0C6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 11:04:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXUrXJhs52xekZYmEeTD725q6/Fby/u2/8c47jm7nvnW3/xqq8k0CmLbyZa/8xjTxjQTgx9rz/kZ0GY79ukIJi0auuIschKZthc5jt/igoftmxTje+yBS1aNSy+c+tq0XtE3W7LJ/GDatX5he9+QOJoUvkaBS2m9E2xaJ+4pwtk315CjtB/JnSt+YowfcBV//Sw5sznLkgpqVhClV4irVlX8JPVzkfJL5WZ11lBa5Io4f+fxrrT6LE2OoAdbh01lopaGf6LZVoDFqJjKPu0mBkSk+b91Qyem942mrie9C/IACcOfJkOFWQU856sWholEc4+zbC1QX9hVXmWcmLd6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSqcADhvlVJ7LO0LRcox2vn8jpKEVTOjLBlNWYARao8=;
 b=NticaE/O+TOQQr/02I9PPxkdnSN15XlV1/JIrczvzzhJe2+7owCY20elKY/YBOiOTEYET5EAxfJvmxgBfy4JUvpHEoUS/seeQioLHcHvd+bdizGH8ZQvqoNyFNN049yKekwknSH5eAfOjpayTtu1A5ZwjgllimlvLTTJbXYJFyKtrEdnIgytx3YO62jU/77j7Ns7+bK7moNjSpHg57l+eGeLzHHseNK6sNwiTzMEROrg4fbGywcnSpLihIg6B8X4NQ9gi9QIswIuf6cRoRdALiL07Q+mKjEeJRt7i+3uJsICTb1QE2yl6RpB4mql2ty6K2KEJlLzCJMCOdjxTVNbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSqcADhvlVJ7LO0LRcox2vn8jpKEVTOjLBlNWYARao8=;
 b=JNyVv/PABV8SjM6+GBmsOEcZqwkRWtBeIBolgQ+P1xiLzLrZqf8u27E0i4DTf6PUwoSwiKFfdGP4LtZWyE0y38to1SqWVODLn1NNaSQQ+r/G7o26RV1ru+2MluolaqStUnkhHThdAJBdffUUxq9nMyXuU8I8Z0o+Hro9BbD8v2riOHlQ0N96618XLMJtkTFjEKEM5T2gvP63dJxy44G44tRqkL/x8iTE+c9yN/2OqJUX/0CBwQT3EmQVhDaKs3Uz7VotWAlxbWQxK1JaWbUUPEBp0OdqS5KyTeaJzKArveyOReWPf8AV0BWXBQfEOSCvGqjflfO6/HZShD6vEtHkGw==
Received: from BN8PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:70::29)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 15:04:46 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::73) by BN8PR04CA0016.outlook.office365.com
 (2603:10b6:408:70::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 15:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 15:04:46 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 08:04:45 -0700
Received: from sumitg-l4t.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 15:04:40 +0000
From: Sumit Gupta <sumitg@nvidia.com>
To: <eric.auger@redhat.com>
Subject: Re: [PATCH v14 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
Date: Thu, 22 Apr 2021 20:34:38 +0530
Message-ID: <1619103878-6664-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <f99d8af1-425b-f1d5-83db-20e32b856143@redhat.com>
References: <f99d8af1-425b-f1d5-83db-20e32b856143@redhat.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02cb4a85-3f6a-42dc-d239-08d9059ff7ed
X-MS-TrafficTypeDiagnostic: CH2PR12MB4039:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4039EE93B47B1378B1A539B2B9469@CH2PR12MB4039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aS7IBfHHoR+5HubceEs+Qh/RrdKpvrqz7PiCvNrgIZPXqgjJRsnzC4YrjGid1lVDvr2tM0N9zR0SSA1meD7MTA3FAWhVzpBNTmvN422T+yqoIbeSoWaMHlTGFEqWj8OSnQYd/K3XSi8TAP4Z4Hw8I6NmTj1kxFFlmerzTnVWYLdfP7F+2OSqxInSVBC/G/nJIO4x2CcJsMCO2Bbp1fb+p7rzN2lreXXgzLCNclRNznARX+fbjGV/rma60puwynxQkHyrFXE+QPOaiwhpibD79XsFmjl/vLLbdlrruienLV1aa9V8/aqS93DCsh8E0fdC4Xwn0zFW4mpBvTKtZbBmMdejFo4dUQdCzlTgpLQosOzSK08MURkmPkuJgy5eqG3c/8z0ZONXUQfHyD9pf1eL6WIBkzvdLdkE4GtFOvG2/FtHFNNEhGT7U69t66zFaLTE28eeg1f8eqC3OcaM7acW4Aj8bkHXPNzlHIgtjFgWmXnwtNdcfUfXIMBAOTNsEKoLfEweclxFMOIVO+noxc4VEvWw8r7lS5MzgtD7+RiJdjITOZFkCLTlXzDeVnpzEsHUgQ5dR37QB5bTR92gAt3ATjveQ2XE7vJwFOCSpRalCWXXaVQrVgP8pxsSkQllzFQwrQrBtKx3ThKCdPwKoGMR0w==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(36756003)(558084003)(186003)(7416002)(426003)(26005)(8936002)(107886003)(8676002)(316002)(2906002)(6916009)(356005)(336012)(70206006)(82740400003)(70586007)(7636003)(83380400001)(36860700001)(82310400003)(4326008)(47076005)(7696005)(2616005)(5660300002)(54906003)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:04:46.5264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cb4a85-3f6a-42dc-d239-08d9059ff7ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
X-Mailman-Approved-At: Thu, 22 Apr 2021 11:13:34 -0400
Cc: vdumpa@nvidia.com, jean-philippe@linaro.org, wangxingang5@huawei.com,
 kvm@vger.kernel.org, vivek.gautam@arm.com, maz@kernel.org, joro@8bytes.org,
 will@kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, vsethi@nvidia.com, lushenming@huawei.com,
 alex.williamson@redhat.com, zhangfei.gao@linaro.org, sumitg@nvidia.com,
 robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

Hi Eric,
I have validated the v14 of the patch series from branch "jean_sva_current_2stage_v14".
Verfied nested translations with NVMe PCI device assigned to Qemu 5.2 Guest.
Had to revert patch "mm: notify remote TLBs when dirtying a PTE".

Tested-by: Sumit Gupta <sumitg@nvidia.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
